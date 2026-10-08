# google_fonts_api — agent start

Submodule of **fontyourface** (`part_of: fontyourface`). A **Google Fonts provider**: pid
`google_fonts_api`, provider name "Google Fonts". No plugin type — it implements
`hook_fontyourface_api()`, `hook_fontyourface_import()`, `hook_page_attachments()` and
`hook_form_font_settings_alter()`.

- **Setup:** enter a Google API key at `/admin/appearance/font/settings` — stored in
  `google_fonts_api.settings:google_api_key`. The Import button is disabled until a valid key
  is present (validated by a live call to the webfonts API).
- **Import:** fetches `https://www.googleapis.com/webfonts/v1/webfonts?key=…` and saves one
  `font` per family × variant × subset via `fontyourface_save_font()`. Auto-import at install
  is intentionally disabled (catalog too large).
- **Render:** `hook_page_attachments()` aggregates enabled Google fonts into a single
  `https://fonts.googleapis.com/css?family=…&subset=…&display=swap` `<link>`.

See the parent for the provider hook API and the `font`/`font_display` model:
`../../../../fontyourface/4.2.x/agent/start.md`.
