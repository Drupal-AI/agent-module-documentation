CDN UI is the optional administrative interface for the CDN module: a settings form that writes the `cdn.settings` configuration through the browser. It can be uninstalled once the CDN is configured.

---

CDN UI ships inside the CDN project and depends on `cdn`. It adds a single settings form (`Drupal\cdn_ui\Form\CdnSettingsForm`) at `/admin/config/services/cdn` (route `cdn_ui.settings`, menu link under *Configuration → Web services*), gated by the `administer CDN configuration` permission. The form uses vertical tabs to edit the same `cdn.settings` object the CDN module reads: a **Status** tab (the "Serve files from CDN" checkbox → `cdn.settings:status`) and a **Mapping** tab (mapping type and the CDN domain, plus condition presets such as "all files except CSS and JS"). Because the CDN module itself has no UI, CDN UI is how most site builders configure it without hand-editing YAML. It provides no config of its own — it is purely a front end onto `cdn.settings` — so once configuration is complete it can be uninstalled and the settings remain in effect.

---

- Turn CDN file serving on or off via the Status tab checkbox (`cdn.settings:status`).
- Enter the CDN domain (e.g. a CloudFront delivery address) without editing YAML.
- Choose the mapping type (simple) and its file-extension conditions in the browser.
- Apply the "all files except CSS and JS" preset from the UI.
- Give non-developers a form to configure the CDN safely under one permission.
- Restrict who can change CDN settings with the `administer CDN configuration` permission.
- Review the current CDN configuration in a readable admin form.
- Configure the CDN, then uninstall CDN UI to keep the admin surface minimal.
- Reach the form quickly from the *Web services* group in the admin Configuration page.
- Set up a CDN on a site where config-as-code is not the workflow.
- Switch the CDN domain when migrating CDN providers.
- Toggle CDN serving during troubleshooting from a single screen.
- Hand off CDN configuration to a client editor with a scoped permission.
- Validate a CDN domain through the form's built-in constraints before saving.
- Serve as the click-through counterpart to the CDN module's config-only workflow.
- Use it temporarily on a staging site to generate the desired `cdn.settings`, then export.
- Keep the CDN module lean in production by removing the UI after setup.
- Configure CDN mapping alongside the far-future feature that the CDN module manages.
- Provide a discoverable entry point (menu link) for CDN configuration.
- Edit CDN settings without needing drush access to the server.
