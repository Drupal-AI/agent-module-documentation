# Paragraphs Inline Entity Form Example — agent index

Config-only **demo submodule** of `paragraphs_inline_entity_form`. No PHP, no plugins, no routes,
no permissions, no settings page. Enabling it installs demo config to showcase inline paragraph
embedding.

Parent: [../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md)

Installs (from `config/install` + `config/optional`):
- Node type `paragraphs_ief_example` (body + `field_ief_paragraphs`) and its form/view displays.
- Paragraph types: `paragraphs_ief_text`, `paragraphs_ief_image`, `paragraphs_ief_gallery`,
  `paragraphs_ief_columns`, `paragraphs_ief_view`, `paragraphs_ief_facebook`, `paragraphs_ief_twitter`,
  `paragraphs_ief_instagram`, `paragraphs_ief_youtube` — each with fields, default + preview displays.
- Text formats `paragraphs_ief_example` (CKEditor 5 with the Paragraphs embed button + "Display
  embedded entities" filter) and `embed`.
- Deps: `node`, `image`, `block`, `block_content`, `path`, `menu_ui`, `views`, `datetime`, parent module.

Nothing to call programmatically — reference these YAML files as a working configuration example.
No security surface.
