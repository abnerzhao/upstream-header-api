return {
  no_consumer = true,
  fields = {
    path = {type = "string", required = false, default="api"},
    header_key = {type = "string", required = false, default="X-Version"},
  },
  self_check = function(schema, plugin_t, dao, is_updating)
    -- perform any custom verification
    return true
  end
}
