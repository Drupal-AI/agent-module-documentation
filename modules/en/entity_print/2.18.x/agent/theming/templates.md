# Theming print output

## Template
`hook_theme()` defines `entity_print` → `templates/entity-print.html.twig`, variables:
- `title` — document title
- `content` — the rendered entity render array
- `entity_print_css` — CSS assets collected for the print

Override it in your theme as `entity-print.html.twig` (or a suggestion) to control the document
wrapper. This is the whole HTML document handed to the print engine.

## Print CSS (recommended styling path)
Attach a print-only stylesheet from your **theme's** `*.info.yml`:
```yaml
entity_print:
  css:
    all: css/print.css
```
Entity Print's `AssetCollector` automatically picks up an `entity_print` library declared by the
active theme, so screen and print styling stay separate. The module's own default stylesheet can
be toggled off with the `default_css` setting ([../configure/settings.md](../configure/settings.md)).

## Render element
`#type => 'print_link'` (`Element/PrintLink`) renders a themed link to the print route; used by
the "View PDF" pseudo-field and the Print Links block.

To debug the exact HTML that will be rendered, visit the entity's
`print/{export_type}/{entity_type}/{id}/debug` route.
