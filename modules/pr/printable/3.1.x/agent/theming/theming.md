# Theming the printable output

`printable_theme()` registers these theme hooks (templates in `printable/templates/`):

| Hook | Template | Variables |
|---|---|---|
| `printable` | `printable.html.twig` | `header`, `content`, `footer` (+ preprocess adds `base_url`, `title`, `html_attributes`, optional `include_css`, `link_canonical`, `send_script`/`close_script`) |
| `printable_header` | `printable-header.html.twig` | `logo_url` |
| `printable_footer` | `printable-footer.html.twig` | `footer_links` (+ preprocess adds `source_url`) |
| `printable_navigation` | (no template; used for the Print/PDF links element) | `printable_link` |

`template_preprocess_printable()` wires in the canonical link (`link_canonical` setting), the
"send to printer" JS (`send_to_printer`, and `close_window`), and the extra CSS
(`css_include` via the `printable.css_include` service).

## Print-specific template suggestions

While a printable page is being built (`printable_preparing_content()` is TRUE),
`printable_theme_suggestions_alter()` appends a `__printable` suffix to **every** theme
suggestion. So you can override any template just for print output by adding the
`__printable` variant, e.g.:

- `node.html.twig` → `node--printable.html.twig`
- `field.html.twig` → `field--printable.html.twig`
- `node--article.html.twig` → `node--article--printable.html.twig`

Place these in your theme to strip navigation, sidebars, etc. from the printable render.

The `printable_pdf` submodule additionally registers `printable_pdf_header` /
`printable_pdf_footer` hooks for PDF header/footer content.
