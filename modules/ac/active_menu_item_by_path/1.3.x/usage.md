<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Active menu item by path marks menu links as being in the active trail when the current page's URL alias contains the link's path, for menus you opt in.

Use it when default active-trail detection misses items (e.g. deep aliases, views pages) and you want a link highlighted based on path matching.

- Implements `hook_preprocess_menu()` for configured menus only.
- Sets `in_active_trail = TRUE` when the current alias contains the link URL.
- Adds the `url.path` cache context so highlighting varies by page.
- Handles nested/child menu items recursively.

---

Install and configure:

- Enable `drush en active_menu_item_by_path`.
- Grant `access active menu settings` to trusted admins.
- Visit `/admin/config/content/active-menu-settings`.
- Check the menus that should get path-based active detection.
- Save; clear cache if needed.

---

- Only menus listed in `allowed_types` config are processed.
- The current path is resolved via `path.current` and `path_alias.manager`.
- Matching uses `str_contains(current_alias, link_url)`.
- The `<front>` link is de-highlighted unless the path is `/node/1`.
- Child items (`below`) are processed by the same recursive closure.
- No output is altered beyond the `in_active_trail` flag and cache metadata.
- Works with themes that render active-trail classes from that flag.
- Settings are stored in `active_menu_item_by_path.settings`.
- Substring matching can over-match (e.g. `/a` matches `/about`); design link paths accordingly.
- Combine with theme CSS targeting `.menu-item--active-trail`.
- Purely presentational; no security surface.
- Enable only for menus that need it to limit overhead.
- Test on aliased and non-aliased routes.
- Verify front-page handling suits your site's front config.
- Clear caches after changing the menu selection.
