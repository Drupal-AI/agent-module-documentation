<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatters — text / markdown / HTML

Three services turn the element array from `UnstructuredApi::structure()` into rendered field
values. All implement `Drupal\unstructured\Formatters\FormatterInterface`:

```php
public function format(array $results, $split): array;
```

`FormatterBase` (constructor args `@file_system`, `@file.repository`) is the shared base; it holds
the file services used to write extracted images.

| Service | Class | `$splitter` | Notes |
|---------|-------|-------------|-------|
| `unstructured.text_formatter` | `TextFormatter` | `"\n"` | Plain text; tables → aligned pipe grid via `renderTable()`; everything else → element `text`. |
| `unstructured.markdown_formatter` | `MarkdownFormatter` | `"\n\n"` | Markdown headings (`#` × `category_depth+1`), list items, `*emphasis*`, `**footer**`, `![Image](uri)`, `---` page breaks, pipe tables; inline links re-inserted with `substr_replace`. |
| `unstructured.html_formatter` | `HtmlFormatter` | `"<br />\n"` | `<p>`/`<h*>`/`<ul><li>`/`<hr />` markup; `Table` returns the API's `metadata.text_as_html`; `Image` → `<img>` with `data-entity-uuid`; `EmailAddress` → `mailto:` link. |

## `$split` modes

Same loop in each formatter:

- `page` — key output by `metadata.page_number` (one string per page).
- `element` — one string per element (increment counter).
- default/`none` — concatenate everything into `$returnTexts[0]`.

## Image extraction (markdown & HTML)

When an element is `type: Image`, `generateImageFile()` base64-decodes `metadata.image_base64`,
picks an extension from `metadata.image_mime_type`, and writes a **permanent** managed file via
`fileRepository->writeData()`:

- `MarkdownFormatter` → `public://unstructured/…`, returns `![Image](<uri>)`.
- `HtmlFormatter` → `public://ai_interpolator_unstructured/…`, returns an `<img src=...>` tag.

## Table rendering

`renderTable()` (text & markdown) parses the API's `text_as_html` by splitting on `</tr>` /
`</td>`/`</th>`, `strip_tags`+`trim`s each cell, and rebuilds a space-padded pipe table. The HTML
formatter instead passes `text_as_html` through unchanged.

## Caller

The AI Automator plugins pick a formatter by the `unstructured_output_format` setting
(`text`/`markdown`/`html`) and call `format($response, $split)` — see
[../plugins/automators.md](../plugins/automators.md).
