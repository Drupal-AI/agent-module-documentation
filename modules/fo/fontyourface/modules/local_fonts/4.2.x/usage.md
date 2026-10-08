Local (self-hosted) fonts provider for @font-your-face (pid `local_fonts`, provider name "Custom Fonts"). Upload your own woff/woff2/svg files and serve them from the Drupal server instead of a third-party CDN.

---

A fontyourface provider submodule that adds a `local_font_config_entity` config entity ("Custom Font") with its own admin UI under `/admin/appearance/font/local_font_config_entity` (route `entity.local_font_config_entity.collection`, add form `.add_form`). Each Custom Font stores a family name, style, weight, classification and the raw uploaded `font_woff_data`, `font_woff2_data` and `font_svg_data`. On save, `hook_entity_presave()` runs `local_fonts_save_and_generate_css()` to write the font files and a `font.css` under `public://fontyourface/local_fonts/{id}`, and creates/updates a matching `font` entity (`url` = `local_fonts://{id}`). `hook_page_attachments()` injects a `<link>` to that generated `font.css` for enabled local fonts. It implements `hook_fontyourface_api()` (announcing "Custom Fonts") but imports via the config-entity form rather than a remote API. Requires fontyourface core.

---

- Self-host web fonts on the Drupal server (no third-party CDN / GDPR concern)
- Upload woff, woff2 and svg font files through an admin form
- Define a Custom Font's family name, style, weight and classification
- Auto-generate a `@font-face` `font.css` per uploaded font
- Serve licensed or bespoke fonts that no online provider offers
- Register uploaded fonts as normal `font` entities you can enable/disable
- Apply a self-hosted font to selectors via a Font display rule
- Keep font assets inside the site's public files directory
- List and manage all custom fonts at `/admin/appearance/font/local_font_config_entity`
- Add a new custom font with the "Add Custom Font" action link
- Delete a custom font (and its generated files) via the config-entity delete form
- Combine local fonts with Google/Typekit fonts on the same site
- Avoid external requests for privacy-sensitive or offline sites
- Store multiple weights/styles as separate Custom Font entities
- Migrate legacy theme `@font-face` declarations into managed entities
- Provide brand fonts to editors without exposing raw CSS
