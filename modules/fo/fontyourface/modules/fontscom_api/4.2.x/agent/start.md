# fontscom_api — agent start

Submodule of **fontyourface** (`part_of: fontyourface`). A **Fonts.com / Monotype provider**:
pid `fontscom_api`, provider name "Fonts.com". Implements `hook_fontyourface_api()`, import
logic, `hook_entity_presave()`, and `hook_form_font_settings_alter()`.

- **Setup:** enter an API token at `/admin/appearance/font/settings`
  (`fontscom_api.settings:token`); a **project** id field (`:project`) appears once a token is
  saved. A post-install message points you to the settings form.
- **Import:** pulls fonts from the chosen Fonts.com project into `font` entities (pid
  `fontscom_api`). The Fonts.com API is quirky — some fonts may need enabling on fonts.com.

Parent provider hook API + `font`/`font_display` model:
`../../../../fontyourface/4.2.x/agent/start.md`.
