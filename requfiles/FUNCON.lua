function is_devsaied(msg)  local ta = false  for k,v in pairs(sudo_users) do  if msg.sender_user_id_ == v then  ta = true  end  end  return ta  end 
function is_sudo(msg) local hash = saieddevraider:sismember(DEVRIDER..'sudo:bot',msg.sender_user_id_)  if hash or is_devsaied(msg)  then  return true  else  return false  end  end
function is_bot(msg) if tonumber(BOTS) == BOTS then return true else return false end end 
function is_owner(msg) local hash = saieddevraider:sismember(DEVRIDER..'moder'..msg.chat_id_,msg.sender_user_id_)    if hash or is_devsaied(msg) or is_sudo(msg) then    return true    else    return false    end end
function is_monsh(msg) local hash = saieddevraider:sismember(DEVRIDER..'modergroup'..msg.chat_id_,msg.sender_user_id_)    if hash or  is_devsaied(msg) or is_sudo(msg) or is_owner(msg) then    return true    else    return false    end end
function is_mod(msg) local hash = saieddevraider:sismember(DEVRIDER..'mods:'..msg.chat_id_,msg.sender_user_id_)    if hash or  is_devsaied(msg) or is_sudo(msg) or is_owner(msg) or is_monsh(msg) then    return true    else    return false    end end
function changetitle(chat_id, title) tdcli_function ({ ID = "ChangeChatTitle", chat_id_ = chat_id, title_ = title  }, dl_cb, nil) end
function is_vipgroups(msg)  local hash = saieddevraider:sismember(DEVRIDER..'vip:groups',msg.sender_user_id_) if hash or  is_devsaied(msg) then return true else return false end end
function is_vipgroup(msg)  local hash = saieddevraider:sismember(DEVRIDER..'vip:group'..msg.chat_id_,msg.sender_user_id_) if hash or  is_devsaied(msg) or is_sudo(msg) or is_owner(msg) or is_mod(msg) or is_vipgroups(msg)  then return true else return false end end
function is_memar(msg)  local hash = saieddevraider:sismember(DEVRIDER..'mepar',msg.sender_user_id_) if hash or  is_devsaied(msg) or is_sudo(msg) or is_owner(msg) or is_mod(msg) or is_mod(msg) or is_vipgroup(msg) or is_vipgroups(msg) then return true else return false end end
function is_banned(chat,user) local hash =  saieddevraider:sismember(DEVRIDER..'raider:baned'..chat,user) if hash then return true else return false end end
function is_gban(chat,user) local hash =  saieddevraider:sismember(DEVRIDER..'raider:gbaned',user) if hash then return true else return false end end
local function getChat(chat_id, cb, cmd) tdcli_function ({ ID = "GetChat", chat_id_ = chat_id }, cb or dl_cb, cmd) end  
local function getParseMode(parse_mode)  local P  if parse_mode then  local mode = parse_mode:lower() if mode == 'markdown' or mode == 'md' then  P = {ID = "TextParseModeMarkdown"} elseif mode == 'html' then   P = {ID = "TextParseModeHTML"}    end  end  return P end    
function raider_sendMsg(chat_id, replytomessageid, from_background, text, DisableWebPagePreview, parsemode, user, cd, raider)
if parsemode and parsemode ~= nil and parsemode ~= false and parsemode ~= "" then
parsemode = getParseMode(parsemode) else parsemode = nil end
Entities = {}
if user then
if text:match('{') and text:match('}') then
local A = {text:match("{(.*)}")}
Length = utf8.len(A[1])
local B = {text:match("^(.*){")}
Offset = utf8.len(B[1])
text = text:gsub('{',' ')
text = text:gsub('}',' ')
table.insert(Entities,{ID = "MessageEntityMentionName", offset_ = Offset, length_ = Length, user_id_ = user})
end
Entities[0] = {ID='MessageEntityBold', offset_=0, length_=0}
if text:match('+') and text:match('-') then
local A = {text:match("+(.*)-")}
Length = utf8.len(A[1])
local B = {text:match("^(.*)+")}
Offset = utf8.len(B[1])
text = text:gsub('+','')
text = text:gsub('-','')
table.insert(Entities,{ID = "MessageEntityMentionName", offset_ = Offset, length_ = Length, user_id_ = user})
end
Entities[0] = {ID='MessageEntityBold', offset_=0, length_=0}
end
Entities[0] = {ID='MessageEntityBold', offset_=0, length_=0}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = replytomessageid or 0,disable_notification_ = 0,from_background_ = from_background,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = DisableWebPagePreview,clear_draft_ = 0,entities_ = Entities,parse_mode_ = parsemode,},}, cd or dl_cb,raider or nil)
end
function sleep(n) os.execute("sleep " .. tonumber(n)) end  
function add_in_ch(msg)
local var = true
if saieddevraider:get(DEVRIDER..'add:ch:id') then
saiedid = saieddevraider:get(DEVRIDER..'add:ch:id')
saieduser = saieddevraider:get(DEVRIDER..'add:ch:username')
local url , res = https.request("https://api.telegram.org/bot"..chaneel.."/getchatmember?chat_id="..saiedid.."&user_id="..msg.sender_user_id_);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
if saieddevraider:get(DEVRIDER..'text:ch:user') then
local textchuser = saieddevraider:get(DEVRIDER..'text:ch:user')
raider_sendMsg(msg.chat_id_, msg.id_, 1, '['..textchuser..']', 1, 'md')
else
chdeva = '\n*📮¦ لا تستطيع استخدام البوت 🍃\n📬¦ عليك الاشتراك في قناة البوت\n🔖¦ معرف القناة  ↡\n* ['..saieduser..']\n✓'
raider_sendMsg(msg.chat_id_, msg.id_, 1, chdeva, 1, 'md');
end
elseif data.ok then
return var
end
else
return var
end
end
function dl_cb(dol, info) end  function getInputFile(file) if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) end
function getChatId(id) local chat = {} local id = tostring(id) if id:match('^-100') then local channel_id = id:gsub('-100', '') chat = {ID = channel_id, type = 'channel'} else local group_id = id:gsub('-', '') chat = {ID = group_id, type = 'group'} end return chat end
local function getChannelFull(channel_id,cb) tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(channel_id).ID }, cb, nil) end 
local function getChannelMembers(channel_id, offset, filter, limit,cb) tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(channel_id).ID,filter_ = {ID = "ChannelMembers" .. filter},offset_ = offset,limit_ = limit}, cb, nil) end
local function chek_bots(channel,cb)  local function callback_admins(extra,result,success)    limit = (result.member_count_ ) getChannelMembers(channel, 0, 'Bots', limit,cb)    raider_sendMsg(channel, 0, 1,'💢*¦* تم طرد البوتات \n', 1, 'md') end  getChannelFull(channel,callback_admins) end
local function saddbyusername(username,cb)  tdcli_function ({    ID = "SearchPublicChat",    username_ = username  }, cb, nil) end
function isnothtml(text) text = text:gsub("<code>", "")  	text = text:gsub("</code>", "")  	text = text:gsub("<b>", "")  	text = text:gsub("</b>", "")  	text = text:gsub("`", "")  	text = text:gsub("*", "")  	text = text:gsub("_", "_")   return text  end
function deleteChatPhoto(chat_id) https.request('https://api.telegram.org/bot'..chaneel..'/deleteChatPhoto?chat_id='..chat_id) end
function setChatDescription(chat_id, description) https.request('https://api.telegram.org/bot'..chaneel..'/setChatDescription?chat_id=' .. chat_id .. '&description=' ..(description)) end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) end
local function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, cb, cmd)  local input_message_content = {    ID = "InputMessageDocument",    document_ = getInputFile(document),    caption_ = caption  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) end
function s_api(web) local info, res = HTTPS.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req end 
function send_inline_key(chat_id,text,keyboard,inline,reply_id) local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..chaneel.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) end
function exportChatInviteLink(chat_id)  local send_api = 'https://api.telegram.org/bot'..chaneel..'/exportChatInviteLink?chat_id='.. chat_id   local linkx = s_api(send_api).result  return linkx end
function getChatMember(chat_id, user_id, cb) tdcli_function ({   ID = "GetChatMember", chat_id_ = chat_id, user_id_ = user_id }, cb or dl_cb, nil) end
function seavusername(id)  tdcli_function ({ID = "GetUser",user_id_ = id},function(arg,data) 
local username = data.username_ if username then
saieddevraider:set(DEVRIDER.."user:Name"..id, "@"..username)
print('\27[30;35m»» USERNAME IS SAEVE ↓\n»» @'..data.username_..'\n\27[1;37m') else
saieddevraider:del(DEVRIDER.."user:Name"..id)
print('»» USERNAME IS NOT SAEVE') end
if data.type_.ID == "UserTypeBot" then
saieddevraider:del(DEVRIDER.."user:Name"..id) end
if data.first_name_ == false then
saieddevraider:del(DEVRIDER.."user:Name"..id)
end end,nil)   
end
function CatchName(Name,Num) ChekName = utf8.sub(Name,0,Num) Name = ChekName return Name..'' end
function CatchNamee(Name,Num) ChekName = utf8.sub(Name,0,Num) Name = ChekName..'' return Name end
function chek_admin(chat_id,set)  local function saddadmen_or_moder(extra,result,success)    limit = result.administrator_count_    if tonumber(limit) > 0 then    getChannelMembers(chat_id, 0, 'Administrators', limit,set)      end    end  getChannelFull(chat_id,saddadmen_or_moder) end
local function saddmods_monshgtoup(channel_id, filter, offset, limit, cb, cmd)   if not limit or limit > 200 then    limit = 200  end tdcli_function ({  ID = "GetChannelMembers", channel_id_ = getChatId(channel_id).ID, filter_ = {   ID = "ChannelMembers" .. filter    },    offset_ = offset or 0,    limit_ = limit  }, cb or dl_cb, cmd) end
function chek_moder(channel,cb)  local function callback_admins(extra,result,success)   limit = result.administrator_count_  if tonumber(limit) > 0 then    getChannelMembers(channel, 0, 'Administrators', limit,cb)     else return raider_sendMsg(channel, 0, 1,'', 1, 'md') end    end  getChannelFull(channel,callback_admins) end
function raiderset(chat_id, raiderphoto) tdcli_function ({ ID = "ChangeChatPhoto",chat_id_ = chat_id,photo_ = getInputFile(raiderphoto) }, dl_cb, nil) end
local function getUserFull(user_id) tdcli_function ({ ID = "GetUserFull", user_id_ = user_id }, dl_cb, nil) end
function raider_get_nae(user_id) if saieddevraider:hget('name',user_id) then text = ''..(string.gsub(saieddevraider:hget('name',user_id), 'false', '') or ' لا يوجد 🔥 ')  end  get_user(user_id) saieddevraider:hdel('name',user_id) return text end
function string:split(sep)  local sep, fields = sep or ":", {}  local pattern = string.format("([^%s]+)", sep)  self:gsub(pattern, function(c) fields[#fields+1] = c end) return fields end
function get_user(user_id) function dl_username(arg, data) username = data.username or ' ' name = data.first_name_ or ' لا يوجد 🔥 ' saieddevraider:hset('username',data.id_,data.username_) saieddevraider:hset('name',data.id_,data.first_name_) end  tdcli_function ({    ID = "GetUser",    user_id_ = user_id  }, dl_username, nil) end
function deleteMessagesFromUser(chat_id, user_id) tdcli_function ({ ID = "DeleteMessagesFromUser", chat_id_ = chat_id, user_id_ = user_id }, dl_cb, nil) end
function formsgg(msgs)  
local saied = ''  
if msgs < 100 then 
saied = 'غير متفاعل ❌' 
elseif msgs < 200 then 
saied = 'بده يتحسن ✔' 
elseif msgs < 400 then 
saied = 'شبه متفاعل ☄' 
elseif msgs < 700 then 
saied = 'متفاعل ⭐' 
elseif msgs < 1200 then 
saied = 'متفاعل قوي 🌟' 
elseif msgs < 2000 then 
saied = 'متفاعل جدا 🎖' 
elseif msgs < 3500 then 
saied = 'اقوى تفاعل 🌞'  
elseif msgs < 4000 then 
saied = 'متفاعل نار 💥' 
elseif msgs < 4500 then 
saied = 'قمة التفاعل 💎' 
elseif msgs < 5500 then 
saied = 'اقوى متفاعل 👑' 
elseif msgs < 7000 then 
saied = 'ملك التفاعل 🎭' 
elseif msgs < 9500 then 
saied = 'امبروطور التفاعل ' 
elseif msgs < 10000000000 then 
saied = 'رب التفاعل 😂💜'  
end 
return saied 
end
function formsggroup(msgs) 
local saied = ''  
if msgs < 100 then 
saied = 'كلش ضعيف 😱' 
elseif msgs < 500 then 
saied = 'ضعيف 😩' 
elseif msgs < 1500 then 
saied = 'غير متفاعله 😰' 
elseif msgs < 5000 then 
saied = 'متوسط 😼' 
elseif msgs < 10000 then 
saied = 'متفاعله 😽' 
elseif msgs < 50000 then 
saied = 'في قمة التفاعل 😍' 
elseif msgs < 90000 then 
saied = 'كروب التفاعل 😻'  
elseif msgs < 100000 then 
saied = 'نار وشرار  🍃' 
elseif msgs < 10000000 then 
saied = 'اقوه تفاعل بتلكرام 🔥' 
end 
return saied 
end
function tfgroup(msgs) 
local saied = ''  
if msgs < 300 then 
saied = '✫'
elseif msgs < 1000 then 
saied = '✰'
elseif msgs < 2000 then 
saied = '✯'
elseif msgs < 3000 then 
saied = '⛤'
elseif msgs < 4000 then 
saied = '⭐'
elseif msgs < 10000000000 then 
saied = '🌟'
end 
return saied 
end
function get_mokforkick(chat_id,user_id)
if tonumber(user_id) == tonumber(SUDO) then
t = 'المطور'
elseif saieddevraider:sismember(DEVRIDER..'sudo:bot',user_id) then
t = 'المطور'
elseif saieddevraider:sismember(DEVRIDER..'moder'..chat_id,user_id) then
t = 'المنشئ'
elseif saieddevraider:sismember(DEVRIDER..'modergroup'..chat_id,user_id) then
t = 'المدير'
elseif saieddevraider:sismember(DEVRIDER..'mods:'..chat_id,user_id) then
t = 'الادمن'
elseif saieddevraider:sismember(DEVRIDER..'vip:groups',user_id) then
t = 'المميز عام'
elseif saieddevraider:sismember(DEVRIDER..'vip:group'..chat_id,user_id) then
t = 'المميز'
else
t = ' '
end
return t 
end
function get_mok(chat_id,user_id)
if tonumber(user_id) == tonumber(SUDO) then
t = 'المطور'
elseif saieddevraider:sismember(DEVRIDER..'sudo:bot',user_id) then
t = 'المطور'
elseif saieddevraider:sismember(DEVRIDER..'moder'..chat_id,user_id) then
t = 'المنشئ'
elseif saieddevraider:sismember(DEVRIDER..'modergroup'..chat_id,user_id) then
t = 'المدير'
elseif saieddevraider:sismember(DEVRIDER..'mods:'..chat_id,user_id) then
t = 'الادمن'
elseif saieddevraider:sismember(DEVRIDER..'vip:groups',user_id) then
t = 'مميز عام'
elseif saieddevraider:sismember(DEVRIDER..'vip:group'..chat_id,user_id) then
t = 'مميز'
else
t = ' '
end
return t 
end
function get_rtpa(chat_id,user_id)
if tonumber(user_id) == tonumber(SUDO) then
t = 'مطور اساسي 💥'
elseif saieddevraider:sismember(DEVRIDER..'sudo:bot',user_id) then
t = 'مطور البوت 👨🏻‍💻'
elseif saieddevraider:sismember(DEVRIDER..'moder'..chat_id,user_id) then
t = 'منشئ 👨🏻‍✈️'
elseif saieddevraider:sismember(DEVRIDER..'modergroup'..chat_id,user_id) then
t = 'مدير 👨🏻‍💼'
elseif saieddevraider:sismember(DEVRIDER..'mods:'..chat_id,user_id) then
t = 'ادمن 👮🏻‍♂'
elseif saieddevraider:sismember(DEVRIDER..'vip:groups',user_id) then
t = 'مميز عام 🌟'
elseif saieddevraider:sismember(DEVRIDER..'vip:group'..chat_id,user_id) then
t = 'مميز ⭐'
else
t = 'عضو 🙋🏻‍♂'
end
return t 
end
function get_mok2(chat_id,user_id)
if tonumber(user_id) == tonumber(SUDO) then
t = 'المطورين'
elseif saieddevraider:sismember(DEVRIDER..'sudo:bot',user_id) then
t = 'المطورين'
elseif saieddevraider:sismember(DEVRIDER..'moder'..chat_id,user_id) then
t = 'المنشئين'
elseif saieddevraider:sismember(DEVRIDER..'vip:groups',user_id) then
t = 'المميزين عام'
else
t = ' '
end
return t end
function get_mok3(chat_id,user_id)
if saieddevraider:sismember(DEVRIDER..'modergroup'..chat_id,user_id) then
t = 'المدير'
elseif saieddevraider:sismember(DEVRIDER..'mods:'..chat_id,user_id) then
t = 'الادمن'
elseif saieddevraider:sismember(DEVRIDER..'vip:group'..chat_id,user_id) then
t = 'المميز'
else
t = ' '
end
return t end
local function rem_lockal(chat_id)
saieddevraider:del(DEVRIDER.."lock:user:name"..chat_id)  saieddevraider:del(DEVRIDER.."lock:hashtak"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Cmd"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Link"..chat_id)  saieddevraider:del(DEVRIDER.."lock:forward"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Keyboard"..chat_id)  saieddevraider:del(DEVRIDER.."lock:geam"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Photo"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Animation"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Video"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Audio"..chat_id)  saieddevraider:del(DEVRIDER.."lock:vico"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Sticker"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Document"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Unsupported"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Markdaun"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Contact"..chat_id)  saieddevraider:del(DEVRIDER.."lock:Spam"..chat_id)
end
local function add_lockal(chat_id)
saieddevraider:set(DEVRIDER.."lock:Bot:kick"..chat_id,'del')  saieddevraider:set(DEVRIDER..'lock:tagservrbot'..chat_id,true)   saieddevraider:set(DEVRIDER.."lock:user:name"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:hashtak"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Cmd"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Link"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:forward"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Keyboard"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:geam"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Photo"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Animation"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Video"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Audio"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:vico"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Sticker"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Document"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Unsupported"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Markdaun"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Contact"..chat_id,'del')    saieddevraider:set(DEVRIDER.."lock:Spam"..chat_id,'del')  
end
function rem_group(chat_id) 
saieddevraider:srem(DEVRIDER..'bot:gpsby:id',chat_id) 
saieddevraider:del(DEVRIDER.."test:group"..chat_id)   
saieddevraider:del(DEVRIDER.."add:bot:group"..chat_id,true) 
rem_lockal(chat_id) 
end
function add_group(chat_id) 
saieddevraider:sadd(DEVRIDER..'bot:gpsby:id',chat_id)
saieddevraider:sadd(DEVRIDER.."botgps",chat_id)  
saieddevraider:set(DEVRIDER.."test:group"..chat_id,'raider')    
saieddevraider:set(DEVRIDER.."add:bot:group"..chat_id, true)   
end
function get_rtba(msg) if is_devsaied(msg) then t = 'المطور'  elseif is_sudo(msg) then t = 'المطور'  elseif is_owner(msg) then t = 'المنشئ'  elseif is_monsh(msg) then t = 'المدير'  elseif is_mod(msg) then t = 'الادمن'  end  return t end
function sendaction(chat_id, action, progress) tdcli_function ({ ID = "SendChatAction",  chat_id_ = chat_id, action_ = {  ID = "SendMessage" .. action .. "Action", progress_ = progress or 100} }, dl_cb, nil) end
local function deleteMessagesFromUser(chat_id, user_id, cb, cmd)  tdcli_function ({ ID = "DeleteMessagesFromUser",  chat_id_ = chat_id, user_id_ = user_id }, cb or dl_cb, cmd) end
function check_markdown(text)  str = text if str then if str:match('_') then output = str:gsub('_',[[_]]) elseif str:match('*') then output = str:gsub('*','\\*') elseif str:match('`') then output = str:gsub('`','\\`') else output = str end return output end end
function is_filter(msg, value)  local names = saieddevraider:smembers(DEVRIDER..'filters:'..msg.chat_id_)  local var = false for i=1, #names do  if names[i] == value and not is_vipgroup(msg) then  var = true      end end return var  end 
function is_muted(chat,user) local hash =  saieddevraider:sismember(DEVRIDER..'mutes'..chat,user) if hash then return true else return false end end
function raidermonshn(chat_id, user_id, msg_id, text, offset, length) local tt = saieddevraider:get(DEVRIDER..'endmsg') or '' tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = msg_id, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text..'\n\n'..tt, disable_web_page_preview_ = 1, clear_draft_ = 0, entities_ = {[0]={ ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user_id }, }, }, }, dl_cb, nil) end
function raider1(chat,user) local sudoe = saieddevraider:sismember(DEVRIDER..'sudo:bot',user)  local vipss = saieddevraider:sismember(DEVRIDER..'vip:groups',user)  local monh = saieddevraider:sismember(DEVRIDER..'modergroup'..chat,user)  local noow = saieddevraider:sismember(DEVRIDER..'moder'..chat,user)  local nomo = saieddevraider:sismember(DEVRIDER..'mods:'..chat,user)  local novip2 = saieddevraider:sismember(DEVRIDER..'vip:group'..chat,user)  if tonumber(SUDO) == tonumber(user) or sudoe or vipss or monh  or noow or nomo  or novip2 then  return true  else  return false  end  end 
function raider2(chat,user) local sudoe = saieddevraider:sismember(DEVRIDER..'sudo:bot',user)  local vipss = saieddevraider:sismember(DEVRIDER..'vip:groups',user)  local noow = saieddevraider:sismember(DEVRIDER..'moder'..chat,user)  if tonumber(SUDO) == tonumber(user) or sudoe or vipss or noow  then  return true else  return false end end 
function raider3(chat,user) local sudoe = saieddevraider:sismember(DEVRIDER..'sudo:bot',user) local noow = saieddevraider:sismember(DEVRIDER..'moder'..chat,user) if tonumber(SUDO) == tonumber(user) or sudoe or monh   then return true else return false end end 
function raider4(chat,user) local sudoe = saieddevraider:sismember(DEVRIDER..'sudo:bot',user)     local noow = saieddevraider:sismember(DEVRIDER..'moder'..chat,user)     local monh = saieddevraider:sismember(DEVRIDER..'modergroup'..chat,user)     local memr = saieddevraider:sismember(DEVRIDER..'mepar',user)    if tonumber(SUDO) == tonumber(user) or sudoe or monh or memr or noow then     return true     else     return false     end     end 
function getInputFile(file) local input = tostring(file) if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile end
function send_inlineraider(chat_id,text,keyboard,inline,reply_id) local url = 'https://api.telegram.org/bot'..chaneel if keyboard then raidertoken = url .. '/sendMessage?chat_id=' ..chat_id.. '&text='..URL.escape(text)..'&parse_mode=html&reply_markup='..URL.escape(json:encode(keyboard)) else raidertoken = url .. '/sendMessage?chat_id=' ..chat_id.. '&text=' ..URL.escape(text)..'&parse_mode=html' end https.request(raidertoken) end
local function getUserProfilePhotos(user_id, offset, limit, cb, cmd)  tdcli_function ({  ID = "GetUserProfilePhotos",   user_id_ = user_id,  offset_ = offset,  limit_ = limit  }, cb or dl_cb, cmd) end
local function deleteMessages(chat_id, message_ids, cb, cmd)   tdcli_function ({  ID = "DeleteMessages",  chat_id_ = chat_id,  message_ids_ = message_ids  }, cb or dl_cb, cmd) end
local function forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, cb, cmd)  tdcli_function ({    ID = "ForwardMessages",    chat_id_ = chat_id,    from_chat_id_ = from_chat_id,    message_ids_ = message_ids,    disable_notification_ = disable_notification,    from_background_ = 1 }, cb or dl_cb, cmd) end
function getUser(user_id, cb) tdcli_function ({   ID = "GetUser",  user_id_ = user_id }, cb, nil) end
local function getMessage(chat_id, message_id,cb) tdcli_function ({ ID = "GetMessage", chat_id_ = chat_id, message_id_ = message_id }, cb, nil) end 
function OpenChat(chat_id, cb) tdcli_function ({ID = "OpenChat",chat_id_ = chat_id}, cb or dl_cb, nil) end
function getChat(chat_id, dl_cb, cmd)tdcli_function ({ID = "GetChat",chat_id_ = chat_id}, dl_cb, cmd) end
function pin(channel_id, message_id, disable_notification)   tdcli_function ({  ID = "PinChannelMessage",  channel_id_ = getChatId(channel_id).ID,  message_id_ = message_id,  disable_notification_ = 1  }, dl_cb, cmd)   end
local function timstoop() local uptime = io.popen("uptime -p"):read("*all") minutes = uptime:match(", %d+ minutes") or uptime:match(", %d+ minute") if minutes then minutes = minutes else minutes = "" end local c_ = string.match(minutes, "%d+") if c_ then c = c_ else c = 0 end return c..' دقيقه ' end
local function getUser(user_id,cb) tdcli_function ({ ID = "GetUser", user_id_ = user_id }, cb, nil) end 
local function changeChatMemberStatus(chat_id, user_id, status) tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatus" .. status }, }, dl_cb, nil) end 
local function getChatHistory(chat_id, from_message_id, offset, limit,cb)tdcli_function ({ ID = "GetChatHistory", chat_id_ = chat_id, from_message_id_ = from_message_id, offset_ = offset, limit_ = limit }, cb, nil) end 
local function getMe(cb) tdcli_function ({ID = "GetMe",}, cb, nil) end
local function unpinChannelMessage(channel_id) tdcli_function ({ ID = "UnpinChannelMessage", channel_id_ = getChatId(channel_id).ID }, dl_cb, nil) end 
local function pinChannelMessage(channel_id, message_id,disable_notification) tdcli_function ({ ID = "PinChannelMessage", channel_id_ = getChatId(channel_id).ID, message_id_ = message_id, disable_notification_ = disable_notification, }, dl_cb, nil) end
function raider_sendMssg(chat_id, text, reply_to_message_id, markdown) send_api = "https://api.telegram.org/bot"..chaneel local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id/2097152/0.5  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  end
function GetInputFile(file)  local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile end
function sendAudio(chat_id,reply_id,audio,title,caption)  pcall(tdcli_function({  ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil))  end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    local input_message_content = {      ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  end
function sendChatAction(chatid,action,func) pcall(tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,nil)) end
function getchat(GroupID,func) pcall(tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,nil)) end
function numrgroup(GroupID)  tdcli_function ({ ID = "GetChannelFull",channel_id_ = getChatId(GroupID).ID },function(arg,tah)   saieddevraider:set(DEVRIDER.."numgrop"..GroupID,tah.member_count_) end,nil)  return saieddevraider:get(DEVRIDER.."numgrop"..GroupID)   end
function title_name(GroupID) pcall(tdcli_function({ID ="GetChat",chat_id_=GroupID },function(arg,data)  saieddevraider:set(DEVRIDER..'group:name'..GroupID,data.title_)  end,nil)) return saieddevraider:get(DEVRIDER..'group:name'..GroupID)  end
local function changeChatTitle(chat_id, title) tdcli_function ({ ID = "ChangeChatTitle", chat_id_ = chat_id, title_ = title }, dl_cb, nil) end
function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  end
function setphoto(chat_id, photo) tdcli_function ({    ID = "ChangeChatPhoto",   chat_id_ = chat_id,  photo_ = getInputFile(photo) }, dl_cb, nil) end
function getChatId(id) local chat = {} local id = tostring(id) if id:match('^-100') then local channel_id = id:gsub('-100', '') chat = {ID = channel_id, type = 'channel'} else local group_id = id:gsub('-', '') chat = {ID = group_id, type = 'group'} end return chat end
local getUser = function(user_id, cb)  tdcli_function({ID = "GetUser", user_id_ = user_id}, cb, nil) end
function adduser(chat_id, user_id, forward_limit) tdcli_function ({ ID = "AddChatMember", chat_id_ = chat_id, user_id_ = user_id, forward_limit_ = forward_limit or 50 }, dl_cb, nil) end
function kick(msg,chat,user)  if tonumber(user) == tonumber(bot_id) then  return false  end  if raider1(chat,user) then  else  changeChatMemberStatus(chat, user, "Kicked")  tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat,user_id_=user,status_={ID="ChatMemberStatusLeft"}},function(arg,ta) end,nil) end  end
function kicck(msg,chat,user)   if tonumber(user) == tonumber(bot_id) then   return false   else  changeChatMemberStatus(chat, user, "Kicked")   tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat,user_id_=user,status_={ID="ChatMemberStatusLeft"}},function(arg,ta) end,nil)  end   end
function monsend(msg,chat,text,user)   
entities = {}   
entities[0] = {ID='MessageEntityBold', offset_=0, length_=0}   
if text and text:match('{') and text:match('}')  then   
local x = utf8.len(text:match('(.*){'))   
local offset = x + 1  
local y = utf8.len(text:match('{(.*)}'))   
local length = y + 1  
text = text:gsub('{','')   
text = text:gsub('}','')   
table.insert(entities,{ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user})   
end   
if text and text:match('❛') and text:match('❜') then   
local x = utf8.len(text:match('(.*)❛'))   
local offset = x + 2
local y = utf8.len(text:match('❛(.*)❜'))   
local length = y + 1
text = text:gsub('❛','')   
text = text:gsub('❜','')    
table.insert(entities,{ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user})   
end   
return tdcli_function ({ID="SendMessage", chat_id_=chat, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_=entities}}, dl_cb, nil)   end
function get_id(msg,saied,text) local get_id = text local get_id = get_id:gsub('IDGET',msg.sender_user_id_) local get_id = get_id:gsub('USERGET',USERNAME_GET) local get_id = get_id:gsub('RTBGET',t) local get_id = get_id:gsub('RTGGET',rtpa) local get_id = get_id:gsub('MSGGET',tonumber(saieddevraider:get(DEVRIDER..'user:messages:'..msg.chat_id_..':'..msg.sender_user_id_) or 1)) local get_id = get_id:gsub('TFGET',formsgg(tonumber(saieddevraider:get(DEVRIDER..'user:messages:'..msg.chat_id_..':'..msg.sender_user_id_) or 1))) local get_id = get_id:gsub('PHOTOGET',saied.total_count_) local get_id = get_id:gsub('NKOGET',nko)
return get_id end
function monsendwel(msg,chat,text,user)   entities = {}   entities[0] = {ID='MessageEntityBold', offset_=0, length_=0}   if text and text:match('<raider>') and text:match('</raider>')  then   local x = utf8.len(text:match('(.*)<raider>'))   local offset = x + 1  local y = utf8.len(text:match('<raider>(.*)</raider>'))   local length = y + 1  text = text:gsub('<raider>','')   text = text:gsub('</raider>','')   table.insert(entities,{ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user})   end   if text and text:match('❛') and text:match('❜') then   local x = utf8.len(text:match('(.*)❛'))   local offset = x   local y = utf8.len(text:match('❛(.*)❜'))   local length = y   text = text:gsub('❛','')   text = text:gsub('❜','')   table.insert(entities,{ID="MessageEntityBold", offset_=offset, length_=length})   end   return tdcli_function ({ID="SendMessage", chat_id_=chat, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_=entities}}, dl_cb, nil)   end
function addmod(chat_id)   tdcli_function ({ID = "GetChannelMembers", channel_id_ = getChatId(chat_id).ID,filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100 },function(arg,data)  local admins = data.members_ for i=0 , #admins do  if data.members_[i].status_.ID == "ChatMemberStatusCreator" then owner_id = admins[i].user_id_  saieddevraider:sadd(DEVRIDER..'moder'..chat_id,owner_id)   tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_ },function(arg,b)   if b.username_ == true then  saieddevraider:set(DEVRIDER.."user:Name"..b.id_,"@"..b.username_) end end,nil)    end  if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then  saieddevraider:sadd(DEVRIDER..'mods:'..chat_id,admins[i].user_id_)   tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_ },function(arg,b)   if b.username_ == true then  saieddevraider:set(DEVRIDER.."user:Name"..b.id_,"@"..b.username_) end end,nil)    else  saieddevraider:srem(DEVRIDER..'mods:'..chat_id,admins[i].user_id_)   end end end,nil)     end
function delete_msg(chatid,mid) tdcli_function ({ID="DeleteMessages", chat_id_=chatid, message_ids_=mid}, dl_cb, nil) end
function trigger_anti_spam(msg,type)
tdcli_function ({
ID = "GetUser",
user_id_ = msg.sender_user_id_
},function(arg,data)
if type == 'kick' then 
if data.username_ then
saied = '\n*📮¦ العضــو » ❪*[@'..data.username_..']*❫\n📬¦ قام بالتكرار هنا وتم طرده *'  
raider_sendMsg(msg.chat_id_, msg.id_, 1, saied, 1, "md")  
kick(msg,msg.chat_id_,msg.sender_user_id_) 
else
kick(msg,msg.chat_id_,msg.sender_user_id_) 
raidermonshn(msg.chat_id_, msg.sender_user_id_, msg.id_, '📮¦ العضــو » ( '..CatchName(data.first_name_,20)..' )\n📬¦ قام بالتكرار هنا وتم طرده \n' , 14, utf8.len(data.first_name_)) 
end
return false  
end 
if type == 'del' then 
delete_msg(msg.chat_id_,{[0] = msg.id_})    
end 
if type == 'keed' then
if data.username_ then
saied = '\n*📮¦ العضــو » ❪*[@'..data.username_..']*❫\n📬¦ قام بالتكرار هنا وتم تقييده *'  
raider_sendMsg(msg.chat_id_, msg.id_, 1, saied, 1, "md")  
HTTPS.request("https://api.telegram.org/bot" .. chaneel .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
saieddevraider:sadd(DEVRIDER..'tedmembars'..msg.chat_id_,msg.sender_user_id_) 
else
raidermonshn(msg.chat_id_, msg.sender_user_id_, msg.id_, '📮¦ العضــو » ( '..CatchName(data.first_name_,20)..' )\n📬¦ قام بالتكرار هنا وتم تقييده \n' , 14, utf8.len(data.first_name_)) 
HTTPS.request("https://api.telegram.org/bot" .. chaneel .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
saieddevraider:sadd(DEVRIDER..'tedmembars'..msg.chat_id_,msg.sender_user_id_) 
end
return false  
end  
if type == 'mute' then
if data.username_ then
saied = '\n*📮¦ العضــو » ❪*[@'..data.username_..']*❫\n📬¦ قام بالتكرار هنا وتم كتمه *'  
raider_sendMsg(msg.chat_id_, msg.id_, 1, saied, 1, "md")  
saieddevraider:sadd(DEVRIDER..'mutes'..msg.chat_id_,msg.sender_user_id_) 
else
raidermonshn(msg.chat_id_, msg.sender_user_id_, msg.id_, '📮¦ العضــو » ( '..CatchName(data.first_name_,20)..' )\n📬¦ قام بالتكرار هنا وتم كتمه \n' , 14, utf8.len(data.first_name_))  
saieddevraider:sadd(DEVRIDER..'mutes'..msg.chat_id_,msg.sender_user_id_) 
end
return false  
end
end,nil)   
end  