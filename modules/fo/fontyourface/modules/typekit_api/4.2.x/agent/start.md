# typekit_api — agent start

Submodule of **fontyourface** (`part_of: fontyourface`). A **Typekit / Adobe Fonts provider**:
pid `typekit_api`, provider name "Typekit". Implements `hook_fontyourface_api()`,
`hook_fontyourface_import()`, and `hook_form_font_settings_alter()`.

- **Setup:** enter a Typekit API token at `/admin/appearance/font/settings` — stored in
  `typekit_api.settings:token`. Setup is required before import (a post-install message points
  you there). The server needs a secure SSL connection to Typekit.com.
- **Import:** `hook_fontyourface_import()` pulls your kit fonts and saves them as `font`
  entities with pid `typekit_api`.

Parent provider hook API + `font`/`font_display` model:
`../../../../fontyourface/4.2.x/agent/start.md`.
