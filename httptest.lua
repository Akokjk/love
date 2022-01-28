local ltn12 = require("ltn12")
local https = require('ssl.https')
local lunajson = require 'lunajson'
https.TIMEOUT= 10
local link = 'https://opentdb.com/api.php?amount=1&type=multiple'
local resp = {}
local body, code, headers = https.request{
                                url = link,
                                headers = { ['Connection'] = 'close' },
                                sink = resp
                                 }
if code~=200 then
    print("Error: ".. (code or '') )
    return
end
--print("Status:", body and "OK" or "FAILED")
--print("HTTP code:", code)
--print("Response headers:")
-- if type(headers) == "table" then
--   for k, v in pairs(headers) do
--     print(k, ":", v)
--   end
-- end
local jsonparse = lunajson.decode(table.concat(resp), 31)

print(jsonparse["question"])
