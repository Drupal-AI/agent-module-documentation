<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colorbox Load — agent index

Makes links whose path matches an **NG Lightbox** pattern open the target page in a
**Colorbox** overlay, loaded over AJAX. It has **no config object, no permissions, no
plugins, no Drush commands** of its own — it only adds a *renderer* option to NG Lightbox.

Key facts:

- `configure` route is **`ng_lightbox.settings`** → `/admin/config/media/ng-lightbox`.
  All settings live in the **`ng_lightbox.settings`** config object.
- The renderer id it contributes is **`drupal_colorbox`** (label "Colorbox"); `hook_install()`
  writes `ng_lightbox.settings:renderer = drupal_colorbox`, `hook_uninstall()` sets it to NULL.
- Depends on `colorbox` **and** `ng_lightbox`.

Docs:

- **Turn it on for specific paths / all settings keys** → [configure/paths-and-renderer.md](configure/paths-and-renderer.md)
- **How the AJAX round-trip works, the `colorboxLoadOpen` command, calling it yourself** →
  [api/mechanism.md](api/mechanism.md)
