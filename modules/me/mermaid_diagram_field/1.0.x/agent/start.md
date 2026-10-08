# Mermaid Diagram field — agent index

A `mermaid_diagram` field type + widget + formatter that renders stored Mermaid source as interactive
pan/zoom SVG, plus a reusable `mermaid_diagram` Twig theme hook. No permissions, no Drush. Provides a
config schema for the formatter settings. Mermaid 11.11.0 + svg-pan-zoom load from jsDelivr CDN by default.

- **Field type/widget/formatter, settings keys, modal route, extra_settings JSON, libraries/CDN** →
  [configure/field.md](configure/field.md)
- **The `mermaid_diagram` theme hook, template variables, theme suggestions, render-from-code** →
  [theming/render-element.md](theming/render-element.md)

Key facts:
- Field columns: `title`, `diagram` (Mermaid code), `caption`, `key`, `show_code` (int flag),
  `allow_download` (int flag). `title`/`caption`/`diagram` are required properties.
- Formatter `mermaid_diagram_formatter` settings: `display_in_modal` (bool), `modal_link_text` (string),
  `extra_settings` (raw JSON → `mermaid.initialize()`).
- Modal route `mermaid_diagram_field.modal` = `/mermaid-diagram/modal/{entity_type}/{entity_id}/{field_name}/{delta}`,
  permission `access content`.
- Diagram text is Twig-autoescaped; `js/diagram.js` reads `.mermaid` `textContent` → `mermaid.render()` →
  injects SVG + svg-pan-zoom. Module forces `startOnLoad = false`.
- `configure` in info.yml (`entity.cm_document.config_form`) is a dead reference — no such route exists.
- Also ships a Feeds target `mermaid_feeds_target` mapping all six subfields.
