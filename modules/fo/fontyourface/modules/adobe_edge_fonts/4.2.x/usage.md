Adobe Edge Fonts provider for @font-your-face (pid `adobe_edge_fonts`, provider name "Adobe Edge"). Imports the free Adobe Edge web-font collection — no account or API key required.

---

A fontyourface provider submodule. It implements `hook_fontyourface_api()` (announcing "Adobe Edge", version 3) and `hook_fontyourface_import()`, which fetches the Adobe Edge Fonts list and saves each as a `font` entity (pid `adobe_edge_fonts`) via `fontyourface_save_font()`. No credentials are needed. Because the collection is large, automatic import at install is disabled — a post-install message points you to the @font-your-face settings form to run the import. `hook_page_attachments()` builds the font-loading markup for enabled Adobe Edge fonts. Requires the fontyourface core module.

---

- Use the free Adobe Edge Fonts collection on a Drupal site
- Import Adobe Edge fonts with no account or API key
- Save each Edge font as a manageable `font` entity
- Enable specific Edge fonts and apply them via Font display rules
- Get a post-install prompt to run the (manually triggered) import
- Combine Edge fonts with Google, Typekit or self-hosted fonts
- Filter the font manager by the `adobe_edge_fonts` provider
- Map Edge font metadata (including supported languages) onto `font` fields
- Swap web fonts without hand-coding embed scripts
- Provide editors a curated set of enabled Edge fonts
- Load enabled Edge fonts automatically on rendered pages
- Re-import to pick up catalog changes
- Keep typography consistent across themes
- Avoid per-provider API-key management for a free font source
- Centrally manage Edge typography alongside other providers
- Migrate off inline theme font embeds into managed entities
