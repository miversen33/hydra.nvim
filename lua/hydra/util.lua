local util = {}
local id = 0

---Generate ID
---@return integer
function util.generate_id()
   id = id + 1
   return id
end

---Shortcut to `vim.api.nvim_replace_termcodes`
---@param keys string
---@return string
function util.termcodes(keys)
   return vim.api.nvim_replace_termcodes(keys, true, true, true)
end

function util.get_color_from_config(foreign_keys, exit)
   if foreign_keys == 'run' then
      if exit then
         return 'blue'
      else
         return 'pink'
      end
   elseif foreign_keys == 'warn' and exit then
      return 'teal'
   elseif foreign_keys == 'warn' then
      return 'amaranth'
   elseif exit then
      return 'blue'
   else
      return 'red'
   end
end

function util.get_config_from_color(color)
   if color == 'pink' then
      return 'run', false
   elseif color == 'teal' then
      return 'warn', true
   elseif color == 'amaranth' then
      return 'warn', false
   elseif color == 'blue' then
      return nil, true
   elseif color == 'red' then
      return nil, false
   end
end

---Deep unset metatables for input table all nested tables.
---@param tbl table
function util.deep_unsetmetatable(tbl)
   for _, subtbl in pairs(tbl) do
      setmetatable(tbl, nil)
      if type(subtbl) == 'table' then
         util.deep_unsetmetatable(subtbl)
      end
   end
end

---Return table where all `key`, `value` pairs are reversed.
---```
---    table[key] = value  =>  table[value] = key
---```
---@param tbl table
---@return table
function util.reverse_tbl(tbl)
   local r = {}
   for key, value in pairs(tbl) do
      r[value] = key
   end
   return r
end

function util.recursive_subtables(tbl, subtbl)
   tbl[subtbl] = setmetatable({}, {
      __index = util.recursive_subtables
   })
   return tbl[subtbl]
end


return util