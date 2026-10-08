# highlight.php — manual setup guide

**highlight.php** (`highlight_php`) adds server-side syntax highlighting to the
code samples in your content. It is a text-format filter: once you enable it on a
text format, every `<code>` block in text using that format is coloured when the
page is rendered, using the PHP port of highlight.js
(`scrivo/highlight.php`). The result is `hljs`-classed markup styled by a bundled,
accessible "a11y-light" theme.

Despite the name, the module does **not** execute any PHP — it only highlights
code, it never runs it. The output is always escaped span markup, so it is safe.
Because highlighting happens at render time (and is cached), it is faster and more
SEO-friendly than a client-side JavaScript highlighter that re-colours the page on
every load.

It works in two modes. In **auto** mode it guesses each snippet's language from a
whitelist of languages you actually use. In **manual** mode it reads the language
from the `<code>` tag's class (matching CKEditor's `language-*` convention), so the
language is whatever the editor chose. A small global settings form lets you pick
the mode and tune the whitelist/regex. The module also ships a Twig `|highlight`
filter for highlighting a code string directly in a template. It depends only on
core's **Filter** module and the `scrivo/highlight.php` Composer library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `scrivo/highlight.php` library) and enable the module.

## How to use it

Enabling the module alone does nothing visible — you must turn the filter on for a
text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format (for example *Full HTML*).
2. Tick **"Highlight &lt;code&gt; tags in HTML."** to enable the filter.
3. Order it so it runs after the HTML is assembled, and make sure the format's
   *Limit allowed HTML tags* filter permits `<code>`, `<pre>`, and the `class`
   attribute on `<code>` (the `class` is needed for manual mode).
4. Save. Any content in that format now shows highlighted code blocks. This pairs
   naturally with CKEditor's **Code block** button, which wraps code in
   `<pre><code class="language-xxx">`.

### The settings form

The module adds a small settings page at **Configuration → Content authoring →
highlight.php** (`/admin/config/content/highlight-php`), reachable by anyone with the
*Administer site configuration* permission. Three options are stored in
`highlight_php.settings`:

- **Mode** — `auto` guesses each snippet's language; `manual` reads the language
  from the `<code>` tag's class.
- **Auto languages** — a space-separated whitelist used only in auto mode (default
  `html php javascript css twig yaml go protobuf sql`). Restricting it to the
  languages your site actually uses improves guessing accuracy.
- **Manual regex** — the pattern used in manual mode to pull the language name out
  of the `<code>` tag (default `language-([a-zA-Z1-9]*)`, matching CKEditor). The
  first capture group is the language name.

These settings are global — there are no per-format options.

### Highlighting from a Twig template

The module registers a `|highlight` Twig filter. Pass it an HTML string containing
`<code>` markup and it returns the highlighted, escaped markup (and attaches the
styling library for you):

```twig
{{ my_code_string|highlight }}
```

To restyle the output, add site CSS targeting the `.hljs` class and the `hljs-*`
token classes; the bundled theme is a11y-light.
