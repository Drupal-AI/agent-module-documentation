<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Style On Upload — agent index

Applies a chosen image style to image files at upload time via `hook_file_presave()`, **replacing the stored original** with the processed derivative (not the usual render-on-demand model). Two config values, no permissions of its own, no plugins, no Drush.

- **The two settings, the applier logic, MIME whitelist, and the shipped `upload` style** → [configure/settings.md](configure/settings.md)

Key facts:
- `hook_file_presave()` → service `image_style_on_upload.utility.image_style_applier` (`src/Utility/ImageStyleApplier.php`).
- Acts only on temporary files whose MIME is in `mime_types`; creates a derivative with the configured style then `FileSystem::move(..., FileExists::Replace)` over the original URI.
- Config object `image_style_on_upload.settings`: `image_style` (default `upload`), `mime_types` (default `image/gif image/jpeg image/png`).
- Settings form at `/admin/config/media/image_style_on_upload` (route `image_style_on_upload.settings`, permission `administer site configuration`). `info.yml` has no `configure` key → `configure` is null.
- Ships optional image style `upload` (`config/optional/image.style.upload.yml`): image_scale width 2000, no upscale.
