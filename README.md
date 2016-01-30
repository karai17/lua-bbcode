# Lua BBCode

Lua BBCode is a BBCode parser written in Lua using regular expressions. This module has a very simple API and is extensible.

## API

This module only has one function for processing BBCode tags. To use this function, call the module with the the text you want to parse, and the tags you want parsed. If you put in a tag that doesn't exist, it will simply ignore it.

```lua
local bbcode = require "bbcode"

local text = [[
Bacon ipsum dolor amet pancetta pork chop doner shankle capicola. T-bone
fatback tongue beef ribs pork loin [b]landjaeger[/b] prosciutto corned beef
jowl. Andouille strip steak shoulder sausage, rump kevin t-bone biltong alcatra
drumstick pork belly shankle. [url=Filet]mignon swine[/url] t-bone, meatloaf
short ribs tri-tip pork belly salami andouille sirloin boudin.
]]

local parsed = bbcode(text, { "b", "url" })
```

Below is a list of available tags.

### Built-in Tags

* \[b]Bolded Text\[/b]
* \[i]Italicized Text\[/i]
* \[u]Underlined Text\[/u]
* \[s]Stricken Text\[/s]
* \[center]Centered Text\[center]
* \[spoiler]Hidden Text (Mouseover to view)\[spoiler]
* \[img]http://placekitten.com/200/300\[img]
* \[youtube]5wFDWP5JwSM\[youtube]
* \[youtube width=640 height=360]5wFDWP5JwSM\[youtube]
* \[font='Noto Sans']Text with a Different Font\[font]
* \[size=150]Text 150% Normal Size\[size]
* \[color=red]Red Text\[color]
* \[color=#ff0000]Red Text\[color]
* \[style=display:block; position:absolute; top:0;]Full Inline CSS\[style]
* \[quote]A fish in the bush is worth two in the pants.\[quote]
* \[quote=Abraham Lincoln]The trouble with quotes on the Internet is that you never know if they are genuine.\[quote]
* \[url]http://google.com\[url]
* \[url=http://google.com]Google\[url]
* \[email]me@example.com\[email]
* \[email=me@example.com]Email me!\[email]
* \[\*]List item
* \[list]Unordered List\[list]
* \[list=1]Ordered List (decimal)\[list]
* \[list=a]Ordered List (alpha)\[list]
* Convert all \\n to &lt;br /&gt;
* \[code]local x = 5\[code]
* \[code=lua]local y = 7\[code]

### Extend Tags

You can add your own tags, or overwrite the built-ins.

```lua
local pattern = "\\[b\\](.*?)\\[\\/b\\]"
local replace = [[<strong>%1</strong>]]
bbcode.extend("b", pattern, replace)
```

### Included Arrays

For your convenience, several preset tag arrays are included.

* **bbcode.all** - All tags are parsed
* **bbcode.basic** - Only the essentials are parsed
* **bbcode.text_only** - All of the text tags are parsed
* **bbcode.embed_only** - Only the tags that embed data are parsed

## Caveats

Some tags need to be parsed before others to generate the best possible HTML. All of the built-in presets are ordered in such a way as to generate the best HTML. As a rule of thumb, if you use the `n` tag, include it at the end of your array. EXCEPT! make sure it is before `code`. `{ [anything], n, code }`. Simple.

## Dependencies

* `lrexlib-pcre` - `$ luarocks install lrexlib-pcre`
