<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Favicons turns one uploaded PNG into a full favicon / app-icon set plus a web app manifest and injects the markup into every page's head.

---

Favicons is a small SEO/theming module that removes the busywork of preparing site icons by hand. An administrator uploads a single source PNG on the settings form (`/admin/config/search/favicons`); on save the `FaviconsGenerator` service builds derivatives through two core Image styles (96x96 and 180x180) and stores them under `public://favicons/`. The module implements `hook_page_attachments()` to add the `<link rel="icon">` / `apple-touch-icon` tags, a `<link rel="icon" type="image/svg+xml" href="/favicon.svg">`, and a `<link rel="manifest" href="/site.webmanifest">` to the `<head>` of every page, first removing any existing `rel="icon"` head link so its own tags win. Two public routes render on demand: `/favicon.svg` (`FaviconsController::faviconSvg`) wraps the source image in an SVG `<image>` element, and `/site.webmanifest` (`FaviconsController::siteWebmanifest`) returns a JSON web app manifest built from config (name, short name, theme colour, background colour, icon list). Settings persist in the `favicons.settings` config object, and the module installs at a very high weight (`module_set_weight('favicons', 9999)`) so it runs late enough to override theme favicon settings after a cache clear.

---

- Generate a complete favicon and app-icon set from a single uploaded PNG.
- Produce a 96x96 icon and a 180x180 apple-touch-icon via core Image styles.
- Serve a scalable `/favicon.svg` derived from the uploaded source image.
- Serve a `/site.webmanifest` web app manifest for installable / PWA-style behaviour.
- Add the icon `<link>` tags to the `<head>` of every page automatically.
- Inject the `<link rel="manifest">` reference without editing the theme.
- Override a theme's built-in favicon by running late in the head-hook order.
- Configure the app name and short name advertised in the web manifest.
- Set the manifest `theme_color` and `background_color` from a hex value.
- Replace all site icons at once by uploading a new source PNG and saving.
- Restrict icon upload/configuration to a dedicated `administer favicons` permission.
- Keep icon derivatives in `public://favicons/` for direct browser access.
- Give iOS/Android home-screen bookmarks a proper 180x180 touch icon.
- Provide browsers with an SVG favicon fallback alongside PNG icons.
- Centralise favicon management in one admin form instead of hand-written markup.
- Avoid manually crafting multiple icon files at different resolutions.
- Regenerate derivatives on demand by re-saving the settings form.
- Expose the icon set to any client that reads a web app manifest.
- Fit favicon setup into a config-managed workflow (config object + schema).
- Use core Image styles so icon scaling reuses the site's image toolkit.
