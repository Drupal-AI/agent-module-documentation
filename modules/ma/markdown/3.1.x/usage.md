<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Markdown lets content authors write in plain-text Markdown that is transformed into valid HTML, via a text-format filter, a programmatic parsing service, and a Twig filter — backed by pluggable parser libraries (CommonMark, Parsedown, PHP Markdown).

---

The module provides a `filter` plugin (id `markdown`) you add to any text format so submitted Markdown is rendered to HTML on output. Under the hood it defines three plugin types managed by their own managers — **parsers** (`plugin.manager.markdown.parser`; adapters for CommonMark, CommonMark-GFM, Parsedown, Parsedown-Extra, PHP Markdown, PHP Markdown Extra), **extensions** (`plugin.manager.markdown.extension`; per-parser feature add-ons like GFM tables/autolinks), and **allowed-HTML** definitions (`plugin.manager.markdown.allowed_html`; declares which HTML a parser/module/theme permits, integrating with the filter's HTML restrictions). A `markdown` service (`Drupal\markdown\Markdown`) exposes `parse()`, `getParser()`, and cache-aware `load()/loadFile()/loadUrl()/save()` for parsing strings, files or URLs programmatically; a Twig extension adds a `|markdown` filter and `markdown()` function. An admin UI at *Configuration → Content authoring → Markdown* (`/admin/config/content/markdown`, permission `administer markdown`) lists parsers and lets you configure each one (settings, extensions, render strategy). Parsers are external Composer libraries you install yourself (e.g. `league/commonmark`); the module detects which are available and marks missing ones. It requires core `filter` and the `dom`/`libxml` PHP extensions.

---

- Let editors write node body content in Markdown by enabling the Markdown filter on a text format.
- Create a dedicated "Markdown" text format for documentation or README-style content.
- Render GitHub-Flavored Markdown (tables, task lists, autolinks) using the CommonMark-GFM parser.
- Choose a parser per text format (CommonMark vs Parsedown vs PHP Markdown).
- Parse a Markdown string to HTML in custom code with the `markdown` service `->parse()`.
- Render a Markdown file (e.g. a module's README) to HTML with `->loadFile()`.
- Fetch and render remote Markdown from a URL with `->loadUrl()` (cached).
- Output Markdown from a Twig template with `{{ content|markdown }}`.
- Use the `markdown()` Twig function to render a Markdown literal or variable.
- Cache parsed Markdown by id to avoid re-parsing expensive content (`save()`/`load()`).
- Configure CommonMark options (emphasis, unsafe links, max nesting, list markers) per parser.
- Enable specific CommonMark extensions (autolinks, strikethrough, tables) for a parser.
- Restrict which HTML tags a parser may output via the allowed-HTML plugin/render strategy.
- Add a custom parser plugin to integrate another Markdown library.
- Add a custom extension plugin to add a feature to an extensible parser.
- Declare allowed HTML for your module/theme so it survives Markdown filtering.
- Alter Markdown before parsing with `hook_markdown_alter()`.
- Alter the generated HTML after parsing with `hook_markdown_html_alter()`.
- Mark a filter as incompatible with Markdown via `hook_markdown_compatible_filters_alter()`.
- Provide a consistent Markdown authoring experience across content types.
- Show which Markdown parser libraries are installed and configure them from one admin page.
- Convert legacy Markdown-in-text content to rendered HTML on display without changing storage.
