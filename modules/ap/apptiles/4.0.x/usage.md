<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: builds and serves `browserconfig.xml` plus tile/icon head markup for web-app pinning, driven by theme settings.
- When: you want Windows pinned-tile icons and app-tile metadata generated from your theme configuration.

---

- Enable the module; configuration lives in the theme settings form (`system.theme_settings`).
- Set the tile images/colors under the theme settings; the `AppTilesManager` service assembles the output.

---

- Service `apptiles` (`AppTilesManager`) is built with config.factory, theme_handler, cache.default, router.admin_context, and file_system.
- Reads the bundled `browserconfig.xml` template via `simplexml_load_string(file_get_contents(...))`.
- Generates tile metadata per active theme and caches the result in `cache.default`.
- Skips generation on admin routes via the `router.admin_context` check.
- Emits the appropriate `<meta name="msapplication-*">` and icon links in the page head.
- Configure tile colors and images through theme settings rather than a dedicated form.
- Use it to give Windows Start-menu tiles and mobile home-screen icons proper artwork.
- The `browserconfig.xml` is produced from the module's template plus your settings.
- Caching avoids rebuilding tile markup on every request.
- No permissions or public mutation routes are added.
- Works per theme, so different themes can present different tiles.
- Clear caches after changing theme settings so tiles regenerate.
- Point image settings at appropriately sized square icons.
- Complements a full PWA/manifest setup rather than replacing it.
- Test the pinned tile in a supporting browser to confirm artwork.
- Version 4.0.x supports Drupal 8/9/10.
