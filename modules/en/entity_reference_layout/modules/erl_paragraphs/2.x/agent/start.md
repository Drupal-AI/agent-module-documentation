# Entity Reference Layout Paragraphs (erl_paragraphs) — agent index

Config-only submodule of Entity Reference with Layout. Installs a default "Section" paragraph
type for use as an ERL layout section. Depends on `entity_reference_layout`. No PHP, routes,
permissions, services, or Drush.

Parent module: [../../../../2.x/agent/start.md](../../../../2.x/agent/start.md)

Installed config (`config/install` + `config/optional`):
- `paragraphs.paragraphs_type.erl_section` — the "Section" paragraph type (machine name `erl_section`).
- `core.entity_form_display.paragraph.erl_section.default` / `core.entity_view_display.paragraph.erl_section.default`.
- `field.storage.paragraph.field_title` + `field.field.paragraph.erl_section.field_title` — an optional title text field (optional config).

Usage: set your `entity_reference_layout_revisioned` field's section paragraph to `erl_section`.
Nothing configurable; extend the type with more fields via the Paragraphs UI if wanted.
