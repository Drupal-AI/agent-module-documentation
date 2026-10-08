Fonts.com (Monotype) provider for @font-your-face (pid `fontscom_api`, provider name "Fonts.com"). Imports fonts from a Fonts.com project using an API token and project id.

---

A fontyourface provider submodule. It implements `hook_fontyourface_api()` (announcing "Fonts.com", version 3) and imports fonts from your Fonts.com (Monotype) account. Authentication uses an API token and a project id entered on the @font-your-face settings form (`fontscom_api.settings:token` and `:project`, added via `hook_form_FORM_ID_alter`); the project field appears once a token is saved. A post-install message points you to the settings form because setup is required before import. The submodule also hooks `entity_presave`/`preprocess` to manage font loading. Note (from the project README): the Fonts.com API has quirks and you may need to enable some fonts on the Fonts.com website itself. Imported fonts become `font` entities with the `fontscom_api` pid. Requires the fontyourface core module.

---

- Use Fonts.com / Monotype subscription fonts on a Drupal site
- Import fonts from a specific Fonts.com project
- Store a Fonts.com API token (`fontscom_api.settings:token`)
- Store a Fonts.com project id (`fontscom_api.settings:project`)
- Reveal the project field only after a token is saved
- Enable imported Fonts.com fonts and apply them via Font display rules
- Get a post-install prompt to finish Fonts.com setup before importing
- Filter the font manager by the `fontscom_api` provider
- Combine Fonts.com fonts with Google, Typekit or self-hosted fonts
- Work around Fonts.com API quirks by enabling fonts on fonts.com when needed
- Map Fonts.com font data onto standard `font` entity fields
- Centrally manage Monotype typography alongside other providers
- Swap subscription fonts without editing theme CSS
- Provide editors a curated set of enabled Fonts.com fonts
- Re-import after changing the Fonts.com project contents
- Keep typography consistent across front-end and admin themes
