# Configure Markdown Easy

No standalone settings page (`configure` null). You configure it **per text format** at
`/admin/config/content/formats`, plus a small site-wide config object `markdown_easy.settings`.

## Per-format filter setting

Enable the **Markdown Easy** filter on a format; its only setting is:

| Setting | Values | Adds |
|---|---|---|
| `flavor` | `standard` | CommonMark core only. |
| | `github` | + Autolinks, Disallowed Raw HTML, Strikethrough, Tables, Task Lists. |
| | `markdownsmorgasbord` | github + Footnotes + Description Lists. |

Filter config lives in the `filter.format.<id>` entity under
`filters.markdown_easy.settings.flavor`.

## Required filter ordering (security-critical)

Markdown Easy **must run before** core's **"Limit allowed HTML tags and correct faulty HTML"**
(`filter_html`) filter. Markdown Easy generates HTML; `filter_html` is what sanitizes that HTML
against an allow-list. If `filter_html` is absent or ordered before Markdown Easy, generated markup
is not sanitized.

The module enforces the ordering so you normally can't misconfigure it:

- `markdown_easy_form_filter_format_(add|edit)_form_alter` adds
  `_markdown_easy_filter_format_edit_form_validate`, which **sets a form error** if `filter_html`
  is disabled or not weighted after `markdown_easy`.
- It also **warns** if the deprecated `filter_autop` ("Convert line breaks into HTML") is enabled,
  and warns (via `MarkdownUtility::findMissingTags`) about tags/attributes the chosen flavor emits
  that aren't in the format's `allowed_html` (e.g. `<del> <table> <input type checked disabled>`
  for github).
- `hook_requirements` (runtime) reports the same misconfigurations on the status report.

### XSS handling summary

- Default converter config: `html_input => 'strip'` (raw HTML in the source is discarded) and
  `allow_unsafe_links => FALSE` (javascript:/data: style links removed).
- Even so, treat `filter_html` as the real sanitizer and keep it enabled + after this filter.
- The output is passed through as markup; do **not** enable Markdown Easy on a format available to
  untrusted users without `filter_html` after it.

## Site-wide config object `markdown_easy.settings`

| Key | Default | Effect |
|---|---|---|
| `skip_filter_enforcement` | `false` | When true, disables the form validation + `hook_requirements` ordering checks (you own correctness). |
| `skip_html_input_stripping` | `false` | When true, the converter uses `html_input => 'allow'` so raw HTML in the source passes through. Only safe on a trusted format that still runs `filter_html` after. |

These are the deliberate escape hatches; leaving both `false` (the default) is the secure setup.

## Ready-made format

`config/optional/filter.format.markdown.yml` ships a `markdown` format with `markdown_easy`
(weight -50, standard flavor) and `filter_html` (weight -49, after it) already correct. It installs
only if `filter` + `markdown_easy` are present.
