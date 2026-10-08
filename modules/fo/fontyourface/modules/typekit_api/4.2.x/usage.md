Typekit / Adobe Fonts provider for @font-your-face (pid `typekit_api`, provider name "Typekit"). Imports the fonts in your Typekit kits using a Typekit API token.

---

A fontyourface provider submodule. It implements `hook_fontyourface_api()` (announcing "Typekit", version 3) and `hook_fontyourface_import()`, importing the fonts from your Typekit/Adobe kits. Authentication uses a Typekit API token entered on the @font-your-face settings form (`typekit_api.settings:token`, added via `hook_form_FORM_ID_alter`). At install a message directs you to the settings page because setup is required before import. The server must be able to make a secure (SSL) connection to Typekit.com. Imported fonts become `font` entities with the `typekit_api` pid and are loaded on rendered pages by the submodule's page-attachment logic. Requires the fontyourface core module.

---

- Use Adobe/Typekit kit fonts on a Drupal site through @font-your-face
- Import the fonts from your Typekit kits into `font` entities
- Store a Typekit API token on the settings form (`typekit_api.settings:token`)
- Enable specific Typekit fonts and apply them via Font display rules
- Serve subscription/commercial Adobe fonts without hand-coding embed snippets
- Combine Typekit fonts with Google or self-hosted fonts on one site
- Filter the font manager by the `typekit_api` provider
- Re-import after changing kit contents on Typekit.com
- Require a secure SSL connection from the server to Typekit.com
- Get a post-install prompt to finish Typekit setup before importing
- Map kit font metadata onto the standard `font` entity fields
- Centrally manage Adobe typography alongside other providers
- Swap Adobe fonts in/out without editing theme CSS
- Provide editors a curated set of enabled Typekit fonts
- Debug Typekit connectivity via import messages
- Keep font choices consistent across front-end and admin themes
