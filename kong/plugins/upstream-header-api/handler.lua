local BasePlugin = require "kong.plugins.base_plugin"

local UpstreamHeaderApiHandler = BasePlugin:extend()

function UpstreamHeaderApiHandler:new()
  UpstreamHeaderApiHandler.super.new(self, "upstream-header-api")
end

function UpstreamHeaderApiHandler:access(conf)
  UpstreamHeaderApiHandler.super.access(self)

  local upstream_uri = ngx.var.upstream_uri
  local path = conf.path
  local header_key = conf.header_key
  local api_version = nil
  local api_path = string.format('%s/v1/', path)
  local find_str = string.format('%s/', path)

  api_version = ngx.req.get_headers()[header_key]

  if string.match(path, '/$') then
    find_str = path
  end

  if api_version then
    api_path = string.format('%s/%s/', path, api_version)
  end

  upstream_uri = string.gsub(upstream_uri, find_str, api_path)
  ngx.var.upstream_uri = upstream_uri

end

UpstreamHeaderApiHandler.PRIORITY = 100

return UpstreamHeaderApiHandler
