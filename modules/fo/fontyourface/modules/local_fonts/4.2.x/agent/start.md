# local_fonts — agent start

Submodule of **fontyourface** (`part_of: fontyourface`). A **self-hosted font provider**: pid
`local_fonts`, provider name "Custom Fonts". Unlike the API providers it imports **no remote
catalog** — you upload font files.

- **Config entity:** `local_font_config_entity` ("Custom Font"), schema keys `font_family`,
  `font_style`, `font_weight`, `font_classification`, and raw `font_woff_data`,
  `font_woff2_data`, `font_svg_data`.
- **Admin UI:** `/admin/appearance/font/local_font_config_entity`
  (`entity.local_font_config_entity.collection`); "Add Custom Font" at `.../add`.
- **On save:** `hook_entity_presave()` → `local_fonts_save_and_generate_css()` writes the font
  files + `font.css` to `public://fontyourface/local_fonts/{id}` and upserts a `font` entity
  with `url = local_fonts://{id}`.
- **Render:** `hook_page_attachments()` links that generated `font.css` for enabled local fonts.

Parent provider hook API + `font`/`font_display` model:
`../../../../fontyourface/4.2.x/agent/start.md`.
