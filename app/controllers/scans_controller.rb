class ScansController < ApplicationController
  def index
  end

  def show
    scan = Scan.find(params[:id])
    @vulnerabilities ||= scan.vulnerabilities
  end

  def create
    url = params[:url]
    parameters = params[:parameters] || ""
    method = params[:method].nil? ? "" : JSON.generate(params[:method])
    cookies = params[:cookies].empty? ? {} : JSON.generate(params[:cookies].split("\n").map { |line| [line.split(':').first, line.split(':').last] }.to_h)

    options = {
      url: url,
      sid: Digest::MD5.hexdigest(Time.now.to_i.to_s),
      parameters: parameters,
      method: method,
      cookies: cookies
    }
    @scan = Scan.create!(options)
    ScanVulnerabilityWorker.perform_async(@scan.id, options)
    redirect_to scan_path(@scan)
  end

  def destroy
  end
end
