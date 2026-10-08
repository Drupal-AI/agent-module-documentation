PWA turns a Drupal site into an installable Progressive Web App by generating a web app manifest at `/manifest.json` and linking it (plus a `theme-color` meta tag) into pages.

---

The PWA module builds the `manifest.json` a browser needs to treat the site as an installable app. A `Manifest` service (`pwa.manifest`) assembles the manifest from the `pwa.config` config object — basic fields (`name`, `short_name`, `start_url`, `display`, app `id`), recommended fields (`theme_color`, `background_color`, `scope`, `orientation`), app icons (from three uploaded file entities, falling back to bundled 512/192/144 px icons), and optional `description`, `categories`, `lang`, `dir` — and serves it at the `/manifest.json` route (`pwa.manifest`, permission `access pwa`). `pwa_page_attachments()` links the manifest into the page `<head>` and adds a `theme-color` meta tag, but only for users with `access pwa` and only on pages selected by the `manifest_path_mode` / `manifest_paths` rules (an include- or exclude-list of path patterns, default: exclude admin/batch/node-add paths). The manifest configuration form lives at `/admin/config/services/pwa/manifest` (`administer pwa`). A `hook_pwa_manifest_alter()` (and a theme-level alter) let other modules/themes change the generated manifest before it is encoded. Three submodules extend it: **pwa_a2hs** (an "Add to Home Screen" prompt block), **pwa_extras** (Apple/iOS-specific meta tags, touch icons and splash screens), and **pwa_service_worker** (an experimental service worker for offline caching). The module is config-translation aware.

---

- Make a Drupal site installable to a phone/desktop home screen as a standalone app.
- Serve a valid `/manifest.json` describing the app's name, icons, colors and display mode.
- Set the app's display mode to `standalone`, `fullscreen`, `minimal-ui` or `browser`.
- Provide 512/192/144 px app icons from uploaded images (or use the bundled defaults).
- Control the browser theme color and splash background color of the installed app.
- Restrict the manifest link to only certain pages (or exclude admin pages) via path rules.
- Set the app's `start_url` and `scope` so it launches on and is scoped to the right section.
- Add a `theme-color` meta tag matching the site's branding.
- Localise the manifest (`lang`, `dir`) and categorise the app (`categories`).
- Pass `crossorigin=use-credentials` on the manifest link for sites behind HTTP auth.
- Alter the generated manifest from a custom module with `hook_pwa_manifest_alter()`.
- Give end users an "Add to Home Screen" button block (pwa_a2hs submodule).
- Add Apple/iOS touch icons, status-bar styling and splash screens (pwa_extras submodule).
- Enable offline caching with a service worker and an offline fallback page (pwa_service_worker submodule).
- Grant `access pwa` to all content-viewing roles so the manifest/service worker attach.
- Configure everything from one admin form at /admin/config/services/pwa/manifest.
- Translate the manifest fields per language (config translation support).
- Provide an app `id` for stable app identity across installs.
- Export the PWA configuration (`pwa.config`) as part of the site's config.
- Lay the groundwork for push notifications / app-like UX on top of the manifest.
