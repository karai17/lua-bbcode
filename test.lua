require "luarocks.loader"
local bbcode = require "bbcode"

local text = [[
[b][/b]
[b]Bold text[/b]
[i]Italic text[/i]
[u]Underline text[/u]
[s]Strike-through text[/s]
[center]Centered text[/center]
[spoiler]Spoiler text[/spoiler]

[img]http://google.com/favico.ico[/img]
[youtube]PEu6AH2e0bE[/youtube]
[youtube width=640 height=360]PEu6AH2e0bE[/youtube]

[font=Noto Sans]Font text[/font]
[size=150]Resized text[/size]
[color=#ff0000]Coloured text[/color]
[style=color:#ff0000; display:inline-block; width:150px;]Styled text[/style]

[quote]Quoted text[/quote]
[quote=Me]Quoted text[/quote]

[CODE]
local x = 5
[/CODE]

[code=lua]
local y = 7
[/code]

[url]http://google.com[/url]
[url=http://google.com]Google[/url]
[email]example@gmail.com[/email]
[email=example@gmail.com]Email me![/email]

[list]
Junk 1
[*]List item 1
[*]List item 2
[*]List item 3
[*]List item 4
Junk 2
[/list]

[list=1]
Junk 1
[*]List item 1
[*]List item 2
[*]List item 3
[*]List item 4
Junk 2
[/list]

[list=a]
Junk 1
[*]List item 1
[*]List item 2
[*]List item 3
[*]List item 4
Junk 2
[/list]
]]

print(bbcode(text, bbcode.all))
