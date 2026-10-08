Font Squirrel provider for @font-your-face (pid `fontsquirrel_api`, provider name "Font Squirrel"). Imports Font Squirrel's free, commercially usable web fonts — no API key required.

---

A fontyourface provider submodule. It implements `hook_fontyourface_api()` (announcing "Font Squirrel", version 3) and `hook_fontyourface_import()`, which fetches the Font Squirrel catalog and saves each font as a `font` entity (pid `fontsquirrel_api`) via `fontyourface_save_font()`. No credentials are needed. A post-install message points you to the @font-your-face settings form to run the import. The submodule also implements `hook_entity_presave()` and `preprocess_font` hooks to manage the generated font loading/markup for enabled Font Squirrel fonts. Requires the fontyourface core module.

---

- Use Font Squirrel's free, commercial-use web fonts on a Drupal site
- Import the Font Squirrel catalog with no API key or account
- Save each Font Squirrel font as a manageable `font` entity
- Enable specific fonts and apply them via Font display rules
- Get a post-install prompt to run the import from the settings form
- Combine Font Squirrel fonts with Google, Typekit or self-hosted fonts
- Filter the font manager by the `fontsquirrel_api` provider
- Rely on fonts that are licensed for commercial use out of the box
- Map Font Squirrel metadata onto standard `font` entity fields
- Load enabled Font Squirrel fonts automatically on rendered pages
- Swap web fonts without hand-coding embed markup
- Provide editors a curated set of enabled Font Squirrel fonts
- Re-import to pick up catalog changes
- Keep typography consistent across themes
- Avoid per-provider key management for a free font source
- Centrally manage Font Squirrel typography alongside other providers
