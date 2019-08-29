local BasePlugin = require "kong.plugins.base_plugin"

local UpstreamHeaderApiHandler = BasePlugin:extend()

function UpstreamHeaderApiHandler:new()
  UpstreamHeaderApiHandler.super.new(self, "upstream-header-api")
end

function UpstreamHeaderApiHandler:access()
  UpstreamHeaderApiHandler.super.access(self)

  local upstream_uri = ngx.var.upstream_uri
  local api_version = nil
  local version_string = '/api/v1/'

  api_version = ngx.req.get_headers()['X-Version']

  if api_version then
      version_string = string.format("/api/%s/",api_version)
      
  end
  upstream_uri = string.gsub(upstream_uri, '/api/', version_string)
  ngx.var.upstream_uri = upstream_uri

end

UpstreamHeaderApiHandler.PRIORITY = 100

return UpstreamHeaderApiHandler

