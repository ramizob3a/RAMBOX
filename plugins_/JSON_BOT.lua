local function rambo_send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
local function GET_TEXT(msg)
if chat_type == 'super' then 
function add_file(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if File_Name:lower():match('(%d+)') ~= bot_id:lower() then 
rambo_send(chat,msg.id_,"*📮¦ الملف ليس للبوت \n👨🏻‍✈️*")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot' .. chaneel .. '/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..chaneel..'/'..File.result.file_path, ''..File_Name) 
rambo_send(chat,msg.id_,"*📮¦ جاري رفع الملف ♻*")   
else
rambo_send(chat,msg.id_,"*📮¦ الملف ليس بصيغة ال json \n👨🏻‍✈️*")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
vardump(groups)
for idg,v in pairs(groups.GP_BOT) do
 devrambo:sadd(DEVRMBO.."bot:gpsby:id",idg)         
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
devrambo:sadd(DEVRMBO..'moder'..idg,idmsh)  
print('تم رفع '..k..' منشئين')
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
devrambo:sadd(DEVRMBO..'modergroup'..idg,idmder)  
print('تم رفع '..k..' مدراء')
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
vardump(idmod)
devrambo:sadd(DEVRMBO..'mods:'..idg,idmod)  
print('تم رفع '..k..' ادمنيه')
end
end
if v.VIP then
for k,idvip in pairs(v.VIP) do
devrambo:sadd(DEVRMBO..'vip:group'..idg,idvip)  
print('تم رفع '..k..' مميزين')
end
end
if v.linkgroup then
if v.linkgroup ~= "" then
devrambo:set(DEVRMBO.."link:group"..idg,v.linkgroup)   
print('تم وضع رابط ')
end
end
end
end

end
end
local function FILE_JSON_BOT(msg)
if chat_type == 'super' then 
if MSG_TEXT[1] == 'جلب نسخه احتياطيه' and is_devtaha(msg) then
local list = devrambo:smembers(DEVRMBO..'bot:gpsby:id')  
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = devrambo:get(DEVRMBO..'group:name'..v) or ''
NAME = NAME:gsub('"','')
NAME = NAME:gsub('#','')
NAME = NAME:gsub([[\]],'')
link = devrambo:get(DEVRMBO.."link:group"..v) or ''
welcome = devrambo:get(DEVRMBO..'welcome:'..v) or ''
MNSH = devrambo:smembers(DEVRMBO..'moder'..v)
MDER = devrambo:smembers(DEVRMBO..'modergroup'..v)
MOD = devrambo:smembers(DEVRMBO..'mods:'..v)
VIP = devrambo:smembers(DEVRMBO..'vip:group'..v)
if k == 1 then
t = t..'"'..v..'":{"GP_NAME":"'..NAME..'",'
else
t = t..',"'..v..'":{"GP_NAME":"'..NAME..'",'
end

if #VIP ~= 0 then 
t = t..'"VIP":['
for k,v in pairs(VIP) do
local u = devrambo:get(DEVRMBO.."user:Name" .. v) or '@TH3VICTORY'
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
local u = devrambo:get(DEVRMBO.."user:Name" .. v) or '@TH3VICTORY'
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
local u = devrambo:get(DEVRMBO.."user:Name" .. v) or '@TH3VICTORY'
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
local u = devrambo:get(DEVRMBO.."user:Name" .. v) or '@TH3VICTORY'
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}'
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './'..bot_id..'.json', '📮| عدد مجموعات البوت » '..#list..'',dl_cb, nil)
end
if MSG_TEXT[1] =='السيرفر' and is_devtaha(msg) then
rambo_send(msg.chat_id_,msg.id_,io.popen([[
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '• Uptime > '"$uptime"''
]]):read('*all'))
end
if MSG_TEXT[1] == 'رفع' and MSG_TEXT[2] == 'النسخه' then   
if is_devtaha(msg) then
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
add_file(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
end



end
end
return {
CMDS = {
'^(رفع) (.+)$',
'^(جلب نسخه احتياطيه)$',
'^(السيرفر)$',
},
RAMBO = FILE_JSON_BOT,
RAMBO_TEXT = GET_TEXT
}


