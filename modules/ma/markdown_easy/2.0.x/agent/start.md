# Markdown Easy — agent index

A single text-format filter (`markdown_easy`) that converts Markdown → HTML with
`league/commonmark`. Enable it on a text format at `/admin/config/content/formats` (no dedicated
config page; `configure` is null). Depends on core `filter`. Provides config schema; no
permissions, Drush, or plugin types.

- **Enabling on a format, the `flavor` setting, required filter ordering, the two site-wide skip settings, and XSS/sanitization responsibility** → [configure/settings.md](configure/settings.md)
- **`hook_markdown_easy_config_modify` and `hook_markdown_easy_environment_modify`** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Filter id `markdown_easy`, per-format setting `flavor` = `standard` | `github` | `markdownsmorgasbord`.
- Converter runs with `html_input => 'strip'` and `allow_unsafe_links => FALSE` by default — raw HTML and dangerous links are removed before output.
- **Must run before** core `filter_html`; the module enforces this via form validation + `hook_requirements` unless `markdown_easy.settings:skip_filter_enforcement` is true.
- `markdown_easy.settings:skip_html_input_stripping = true` switches to `html_input => 'allow'` (raw HTML passes through — only safe with a trusted format + `filter_html`).
- Ships an optional pre-wired `markdown` text format (`config/optional/filter.format.markdown.yml`).
