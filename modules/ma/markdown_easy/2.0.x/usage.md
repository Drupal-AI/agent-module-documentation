Markdown Easy is a text-format filter that converts Markdown to HTML using the `league/commonmark` library, with three selectable flavors (Standard, GitHub-flavored, and "Markdown Smörgåsbord"). It is designed to run *before* core's "Limit allowed HTML tags" filter, which does the actual sanitization.

---

The module adds a single filter plugin, `markdown_easy` (type `TYPE_TRANSFORM_IRREVERSIBLE`), that you enable on a text format at `/admin/config/content/formats`. Its one per-format setting is `flavor`: **Standard** (CommonMark core), **GitHub** (adds Autolinks, Disallowed Raw HTML, Strikethrough, Tables, Task Lists), or **Markdown Smörgåsbord** (GitHub plus Footnotes and Description Lists). On conversion the CommonMark environment is created with `html_input => 'strip'` and `allow_unsafe_links => FALSE` by default, so raw/embedded HTML and dangerous links are removed before output. Security depends on ordering: Markdown Easy must run **before** the "Limit allowed HTML tags and correct faulty HTML" (`filter_html`) filter, which sanitizes the generated HTML against an allow-list. The module actively enforces this — `hook_form_FORM_ID_alter` on the filter-format add/edit forms adds a validate handler that errors if `filter_html` is missing or ordered before `markdown_easy`, warns if the deprecated `filter_autop` is enabled, and warns about allowed-HTML tags missing for the chosen flavor; `hook_requirements` re-checks enabled formats at runtime. Two site-wide escape hatches in `markdown_easy.settings` can relax this: `skip_filter_enforcement` (disable the ordering checks) and `skip_html_input_stripping` (pass `html_input => 'allow'` so raw HTML survives). The module ships an optional `markdown` text format (`config/optional/filter.format.markdown.yml`) already wired with `filter_html` after the filter. Two hooks (`hook_markdown_easy_config_modify`, `hook_markdown_easy_environment_modify`) let other modules tune the converter.

---

- Let editors write body content in Markdown and have it rendered as HTML.
- Enable GitHub-flavored Markdown (tables, task lists, strikethrough, autolinks) on a format.
- Enable footnotes and description lists via the "Markdown Smörgåsbord" flavor.
- Provide a safe Markdown format that strips raw HTML and unsafe links by default.
- Combine Markdown authoring with core's allowed-HTML sanitization for XSS safety.
- Get build-time guidance on which HTML tags to allow for the chosen Markdown flavor.
- Be warned when a text format orders the filters insecurely.
- Import the ready-made `markdown` text format as a starting point.
- Add a Markdown format for comment fields or user-generated content.
- Render aligned Markdown tables with the bundled alignment CSS library.
- Support autolinking of bare URLs in editor content.
- Render task-list checkboxes (`- [ ]`) in displayed content.
- Add code blocks and inline code from Markdown fences.
- Allow trusted formats to keep raw HTML by enabling `skip_html_input_stripping`.
- Disable the ordering enforcement via `skip_filter_enforcement` for advanced pipelines.
- Extend the CommonMark environment with custom extensions via a hook.
- Modify converter configuration (e.g. footnote/table options) via a hook.
- Migrate legacy `filter_markdown` content to a maintained CommonMark-based filter.
- Offer a lightweight Markdown option without a full WYSIWYG editor.
- Standardize Markdown rendering across multiple text formats on a site.
