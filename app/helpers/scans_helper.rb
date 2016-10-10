module ScansHelper
  def params_parser(parameters, json=false)
    return {} if parameters.empty?

    return JSON.parse(parameters) if json

    body_params = {}
    parameters.split('&').each do |param|
      key, value = param.split('=')
      body_params[key] = value
    end

    body_params
  end

  def cookies_parser(cookies)
    return {} if cookies.empty?

    parsed_cookies = {}
    cookies.split(';').each do |cookie|
      key, value = cookie.split('=')
      parsed_cookies[key] = value
    end
    parsed_cookies
  end

  def headers_parser(headers)
    return if headers.empty?

    parsed_headers = {}
    parsed_cookies = {}
    headers.split("\n").each do |header|
      key, value = header.split(": ")
      if key.downcase == 'cookie'
        parsed_cookies = cookies_parser(value)
      else
        parsed_headers[key] = value
      end
    end
    [parsed_headers, parsed_cookies]
  end

  def group_vulnerbility_count(vulnerabilities)
    [
      {
        name: 'LOW',
        y: vulnerabilities['LOW'] || 0
      },
      {
        name: 'MEDIUM',
        y: vulnerabilities['MEDIUM'] || 0
      },
      {
        name: 'HIGH',
        y: vulnerabilities['HIGH'] || 0
      },
      {
        name: 'INFORMATIVE',
        y: vulnerabilities['INFORMATIVE'] || 0
      }
    ]
  end
end
