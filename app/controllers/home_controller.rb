class HomeController < ApplicationController
  def index
  end

  def scan
    url = params[:url]
    method = params[:method]
    parameters = params[:parameters]
    cookies = params[:cookies]

    options = {
      url: url,
      method: method,
      params: parameters,
      cookies: cookies
    }

    @vulnerabilities = API_Fuzzer.scan(options)
    redirect_to root_path
  end
end
