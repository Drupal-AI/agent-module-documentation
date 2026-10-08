<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deindex Unpublished Files (deindex_unpublished_files) — agent index

On a media entity's publish-state change, **physically relocates the file(s) it references** so
unpublished files stop being publicly downloadable, and restores them on republish. Package `SEO`.
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Depends on core **`file`** and **`media`**.

Important: the "deindex" is done by **moving/renaming the file**, not an HTTP header. There is **no
X-Robots-Tag** emitted and **no `hook_file_download`** — the module never itself grants or denies
file access. It only affects media types whose bundle has a `file`/`image`/`svg_image` field.

## What it provides (from source)

- **`hook_media_presave`** — the enforcement point. OO impl `MediaHooks::mediaPresave()`
  (`src/Hook/MediaHooks.php`, service `deindex_unpublished_files.hooks.media`, `#[Hook('media_presave')]`),
  with a `#[LegacyHook]` procedural shim in `deindex_unpublished_files.module` for Drupal 10.1–11.0.
  Two modes (`unpublish_mode` config): `move` and `prefix`. → [api/file-relocation.md](api/file-relocation.md)
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`) at route
  `deindex_unpublished_files.settings` — `/admin/config/media/media-settings/deindex-unpublished-files`,
  permission `administer site configuration`. Writes config object `deindex_unpublished_files.settings`
  (`unpublish_mode`). → [config/settings.md](config/settings.md)
- **Media usage overview** `UnpublishedMediaUsageForm` (`src/Form/UnpublishedMediaUsageForm.php`) at
  route `deindex_unpublished_files.unpublished_media_usage` —
  `/admin/content/deindex-unpublished-files/unpublished-media`, permission `administer media`.
  Lists media usage and bulk-unpublishes selected media. → [api/media-usage-inspector.md](api/media-usage-inspector.md)
- **Service** `deindex_unpublished_files.media_usage_inspector` = `MediaUsageInspector`
  (`src/Service/MediaUsageInspector.php`) — scans content for media usage. → [api/media-usage-inspector.md](api/media-usage-inspector.md)
- Menu links (`*.links.menu.yml`) under *Config → Media* and *Content*; a CSS-only library
  `deindex_unpublished_files/unpublished_media_usage`; `hook_update_10001` rebuilds router + menu links.

## Not present

No permissions file, no config schema, no `config/install` defaults (so `unpublish_mode` is **null
until saved** — no relocation happens until an admin picks a mode). No Drush, no plugin types, no
response subscriber, no `hook_file_download`, no external HTTP calls.
