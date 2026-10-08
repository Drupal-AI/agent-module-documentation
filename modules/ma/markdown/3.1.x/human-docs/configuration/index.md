# Configuration

There are two things to set up: switch the **Markdown filter** on for a text
format, and choose/configure the **parser** it uses. Everything on this page
requires the **Administer markdown configuration** permission
(`administer markdown`) — grant it at **People → Permissions** to trusted roles.

## 1. Enable the Markdown filter on a text format

The filter is what converts Markdown to HTML when content is displayed.

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Either edit an existing format or add a new one — for documentation or
   README-style content, a dedicated **"Markdown"** format is a clean choice.
3. In the **Enabled filters** list, tick **Markdown**.
4. Save the format.

From now on, any content submitted in that text format is rendered from Markdown
to HTML on output. (Your storage is unchanged — the raw Markdown is what is
stored; the conversion happens at display time.)

## 2. Choose and configure a parser

Each text format that uses the Markdown filter has a **parser** selected in the
filter's settings — for example `commonmark`, `commonmark-gfm`, `parsedown`,
`parsedown-extra`, `php-markdown`, or `php-markdown-extra`. If the library behind
your chosen parser is not installed, the parser resolves to a "missing" state and
Markdown will not render, so make sure you installed the matching Composer package
(see [Installation](../installation/index.md)).

To tune a parser, go to the Markdown admin page at **Configuration → Content
authoring → Markdown** (`/admin/config/content/markdown`). It lists every parser
with its install status. From there you can open a parser and configure:

- **Parser settings** — for example CommonMark's emphasis handling, whether unsafe
  links are allowed, maximum nesting depth, and list-marker behavior.
- **Extensions** — feature add-ons for extensible parsers, such as GitHub-Flavored
  Markdown tables, task lists, strikethrough, and autolinks. Enable only the ones
  you need.
- **Render strategy** — how strictly the parser's output HTML is filtered. The
  default (`filter_output`) lets the text format's other filters and the allowed
  HTML list restrict tags; stricter options are available if you want the parser
  itself to limit output.

## Using Markdown in templates and code (optional, for developers)

Beyond the filter, the module exposes:

- A Twig filter and function: `{{ some_text|markdown }}` renders a variable, and
  `markdown('**hi**')` renders a literal.
- A `markdown` service with methods like `->parse()` (render a string),
  `->loadFile()` (render a file such as a module README), and `->loadUrl()`
  (fetch and render remote Markdown, cached).

See the [`agent/`](../agent/start.md) docs for the service API, the three plugin
types (parser, extension, allowed-HTML), and the `hook_markdown_alter()` /
`hook_markdown_html_alter()` hooks.
