-- regex > lpeg
local rex = require "rex_pcre"

-- pcre compile flags
local cf = "ims"

-- regex patterns
local pattern = {
	b        = "\\[b\\](.*?)\\[\\/b\\]",
	i        = "\\[i\\](.*?)\\[\\/i\\]",
	u        = "\\[u\\](.*?)\\[\\/u\\]",
	s        = "\\[s\\](.*?)\\[\\/s\\]",
	center   = "\\[center\\](.*?)\\[\\/center\\]",
	spoiler  = "\\[spoiler\\](.*?)\\[\\/spoiler\\]",
	img      = "\\[img\\]((?!.*?data:).*?)\\[\\/img\\]",
	youtube  = "\\[youtube\\](\\w*?)\\[\\/youtube\\]",
	youtube2 = "\\[youtube width=(\\d*?) height=(\\d*?)\\](\\w*?)\\[\\/youtube\\]",
	font     = "\\[font=([\\w\\s]*?)\\](.*?)\\[\\/font\\]",
	size     = "\\[size=(\\d*?)\\](.*?)\\[\\/size\\]",
	color    = "\\[color=([#\\w]*?)\\](.*?)\\[\\/color\\]",
	style    = "\\[style=([\\w-:#;\\s\\(\\)\\']*?)\\](.*?)\\[\\/style\\]",
	quote    = "\\[quote\\](.*?)\\[\\/quote\\]",
	quote2   = "\\[quote=(\\w*?)\\](.*?)\\[\\/quote\\]",
	url      = "\\[url\\]((?!.*?data:).*?)\\[\\/url\\]",
	url2     = "\\[url=((?!.*?data:).*?)\\](.*?)\\[\\/url\\]",
	email    = "\\[email\\]([\\w@\\.]*?)\\[\\/email\\]",
	email2   = "\\[email=([\\w@\\.]*?)\\](.*?)\\[\\/email\\]",
	li       = "\\[\\*\\](.*?)(?=\n\\[\\*\\]|\n\\[\\/list\\])",
	list     = "\\[list\\](.*?)\\[\\/list\\]",
	list2    = "\\[list=1\\](.*?)\\[\\/list\\]",
	list3    = "\\[list=a\\](.*?)\\[\\/list\\]",
	n        = "\n(?![^\\[]*\\[\\/code\\])",
	code     = "\\[code\\](.*?)\\[\\/code\\]",
	code2    = "\\[code=(\\w*?)\\](.*?)\\[\\/code\\]",
}

-- match replacements
local replace = {
	b        = [[<strong>%1</strong>]],
	i        = [[<em>%1</em>]],
	u        = [[<span style="text-decoration:underline;">%1</span>]],
	s        = [[<del">%1</del>]],
	center   = [[<div style="text-align:center;">%1</div>]],
	spoiler  = [[<span class="spoiler">%1</span>]],
	img      = [[<img src="%1" alt="" />]],
	youtube  = [[<iframe width="640" height="360" src="https://www.youtube.com/embed/%1" frameborder="0" allowfullscreen></iframe>]],
	youtube2 = [[<iframe width="%1" height="%2" src="https://www.youtube.com/embed/%3" frameborder="0" allowfullscreen></iframe>]],
	font     = [[<span style="font-family:'%1';">%2</span>]],
	size     = [[<span style="font-size:%1%%; line-height:normal;">%2</span>]],
	color    = [[<span style="color:%1;">%2</span>]],
	style    = [[<span style="%1">%2</span>]],
	quote    = [[<quote>%1</quote>]],
	quote2   = [[<quote><cite>%1</cite>%2</quote>]],
	url      = [[<a href="%1">%1</a>]],
	url2     = [[<a href="%1">%2</a>]],
	email    = [[<a href="mailto:%1">%1</a>]],
	email2   = [[<a href="mailto:%1">%2</a>]],
	li       = [[<li>%1</li>]],
	list     = [[<ul style="list-style-type:disc;">%1</ul>]],
	list2    = [[<ol style="list-style-type:decimal;">%1</ol>]],
	list3    = [[<ol style="list-style-type:lower-alpha;">%1</ol>]],
	n        = [[<br />]] .. "\n",
	code     = [[<pre><code class="nohighlight">%1</code></pre>]],
	code2    = [[<pre><code class="%1">%2</code></pre>]],
}

local bbcode = {
	-- Process `b` tag
	b = function(text)
		return rex.gsub(text, pattern.b, replace.b, nil, cf)
	end,
	-- Process `i` tag
	i = function(text)
		return rex.gsub(text, pattern.i, replace.i, nil, cf)
	end,
	-- Process `u` tag
	u = function(text)
		return rex.gsub(text, pattern.u, replace.u, nil, cf)
	end,
	-- Process `s` tag
	s = function(text)
		return rex.gsub(text, pattern.s, replace.s, nil, cf)
	end,
	-- Process `center` tag
	center = function(text)
		return rex.gsub(text, pattern.center, replace.center, nil, cf)
	end,
	-- Process `spoiler` tag
	spoiler = function(text)
		return rex.gsub(text, pattern.spoiler, replace.spoiler, nil, cf)
	end,
	-- Process `img` tag
	img = function(text)
		return rex.gsub(text, pattern.img, replace.img, nil, cf)
	end,
	-- Process `youtube` tag
	youtube = function(text)
		text = rex.gsub(text, pattern.youtube,  replace.youtube,  nil, cf)
		text = rex.gsub(text, pattern.youtube2, replace.youtube2, nil, cf)
		return text
	end,
	-- Process `font` tag
	font = function(text)
		return rex.gsub(text, pattern.font, replace.font, nil, cf)
	end,
	-- Process `size` tag
	size = function(text)
		return rex.gsub(text, pattern.size, replace.size, nil, cf)
	end,
	-- Process `color` tag
	color = function(text)
		return rex.gsub(text, pattern.color, replace.color, nil, cf)
	end,
	-- Process `style` tag
	style = function(text)
		return rex.gsub(text, pattern.style, replace.style, nil, cf)
	end,
	-- Process `quote` tag
	quote = function(text)
		text = rex.gsub(text, pattern.quote,  replace.quote,  nil, cf)
		text = rex.gsub(text, pattern.quote2, replace.quote2, nil, cf)
		return text
	end,
	-- Process `url` tag
	url = function(text)
		text = rex.gsub(text, pattern.url,  replace.url,  nil, cf)
		text = rex.gsub(text, pattern.url2, replace.url2, nil, cf)
		return text
	end,
	-- Process `email` tag
	email = function(text)
		text = rex.gsub(text, pattern.email,  replace.email,  nil, cf)
		text = rex.gsub(text, pattern.email2, replace.email2, nil, cf)
		return text
	end,
	-- Process `list` tag
	list = function(text)
		text = rex.gsub(text, pattern.li,    replace.li,    nil, cf)
		text = rex.gsub(text, pattern.list,  replace.list,  nil, cf)
		text = rex.gsub(text, pattern.list2, replace.list2, nil, cf)
		text = rex.gsub(text, pattern.list3, replace.list3, nil, cf)
		return text
	end,
	-- Process `n` tag
	-- Convert all `\n` characters to `<br />` except within a code tag!
	-- Make sure to run this at the end, but before `code`
	n = function(text)
		return rex.gsub(text, pattern.n, replace.n, nil, cf)
	end,
	-- Process `code` tag
	-- Designed to work with highlight.js (http://highlightjs.org)
	code = function(text)
		text = rex.gsub(text, pattern.code,  replace.code,  nil, cf)
		text = rex.gsub(text, pattern.code2, replace.code2, nil, cf)
		return text
	end
}

-- Process select tags
local function process(text, tags)
	for _, tag in ipairs(tags) do
		text = bbcode[tag] and bbcode[tag](text) or text
	end
	return text
end

-- Add new tags
local function extend(tag, patt, repl)
	if  type(tag)     == "string"
	and type(pattern) == "string"
	and type(replace) == "string" then
		pattern[tag] = patt
		replace[tag] = repl
		bbcode[tag]  = function(text)
			return rex.gsub(text, pattern[tag], replace[tag], nil, cf)
		end
	end
end

-- Some defaults
local basic = {
	"b",
	"i",
	"u",
	"s",
	"spoiler",
	"quote",
	"url",
	"email"
}

local all = {
	"b",
	"i",
	"u",
	"s",
	"center",
	"spoiler",
	"img",
	"youtube",
	"font",
	"size",
	"color",
	"style",
	"quote",
	"url",
	"email",
	"list",
	"n",
	"code"
}

local text_only = {
	"b",
	"i",
	"u",
	"s",
	"center",
	"spoiler",
	"font",
	"size",
	"color",
	"style",
	"quote",
	"url",
	"email"
}

local embed_only = {
	"img",
	"youtube"
}

return setmetatable({
	_LICENSE     = "MIT/X11",
	_URL         = "https://github.com/karai17/lua-bbcode",
	_VERSION     = "1.0",
	_DESCRIPTION = "BBCode parser for Lua.",
	extend       = extend,
	all          = all,
	text_only    = text_only,
	embed_only   = embed_only,
	basic        = basic
}, {
	__call = function(_, ...) return process(...) end
})
