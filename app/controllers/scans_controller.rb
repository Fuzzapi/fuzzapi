class ScansController < ApplicationController
  include ScansHelper
  before_action :load_scan, only: [:show, :vulnerability_chart]

  def index
    @scans = current_user.scans
  end

  def show
    @vulnerabilities ||= @scan.vulnerabilities
  end

  def create
    url = params[:url]
    parameters = params[:parameters]
    method = params[:method].nil? ? "" : JSON.generate(params[:method])
    headers = params[:headers]
    json = params[:json]

    options = {
      url: url,
      sid: Digest::MD5.hexdigest(Time.now.to_i.to_s),
      parameters: parameters,
      method: method,
      cookies: headers, # rename column to headers
      json: json
    }
    @scan = current_user.scans.create!(options)

    headers, cookies = headers_parser(headers)
    job_options = {
      url: url,
      params: params_parser(parameters),
      method: JSON.parse(method),
      cookies: cookies,
      json: json,
      headers: headers,
      scan: @scan.id
    }
    ScanVulnerabilityWorker.perform_async(@scan.id, job_options)
    redirect_to scan_path(@scan)
  end

  def vulnerability_chart
    vulnerabilities = @scan.vulnerabilities.group(:status).count
    render json: group_vulnerbility_count(vulnerabilities)
  end

  def test
    redirect_to params[:url]
  end

  def destroy
  end

  private

  def load_scan
    @scan = Scan.find(params[:id])
  end
end
