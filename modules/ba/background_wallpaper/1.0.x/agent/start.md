<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Background Wallpaper (background_wallpaper) — agent index

Single-image site background utility. An admin uploads one image and picks target content types and/or the front page; the module injects an inline `<style>` rule setting that image as the `#main` element's `background-image` on matching pages.

- Core-only: depends on `system` + `config`. No composer deps, no libraries, no submodules, no Drush, no config schema, no custom permissions.
- Core version: `^10 || ^11`. License GPL-2.0-or-later. Package `other`.

What it provides:
- Config object: `background_wallpaper.settings` with keys `background_image` (managed_file fid array) and `background_target` (array of node-type machine names plus the special `front`).
- Route: `background_wallpaper.settings` — `GET /admin/config/background-wallpaper`, `_form` = `BackgroundWallpaperSettingsForm`, gated by core permission `administer site configuration`.
- Form: `Drupal\background_wallpaper\Form\BackgroundWallpaperSettingsForm` (extends `ConfigFormBase`).
- Hooks (in `background_wallpaper.module`): `hook_help()` (help.page) and `hook_page_attachments()` (the render-time background injection).
- No entities, no plugins, no services of its own.

Solution docs:
- [config/settings.md](config/settings.md) — the settings form, config object/keys, upload location, and target selection.
- [api/rendering.md](api/rendering.md) — how `hook_page_attachments()` decides when to apply and what CSS it emits.
