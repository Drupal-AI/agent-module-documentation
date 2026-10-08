<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# (ADFS) Image Optimizer (advanced_filesystem_image_optimizer) — agent index

Compress images on file save using **PHP GD** (optional WebP copy, optional downscale), tracking
per-file savings. Submodule of Advanced FileSystem. Package `Advanced Filesystem`. Core
`^10 || ^11 || ^12`. Depends on **`advanced_filesystem`**. Requires `ext-gd`. Version 1.0.27.

- **Service, hook, config, Drush, log table, how to operate it** →
  [api/optimizer.md](api/optimizer.md)

## What it provides

- **Service** `advanced_filesystem_image_optimizer.optimizer` → `Service\ImageOptimizerService`
  (`isEnabled`, `appliesToFile`, `optimize`, log/stats helpers). Plus a dedicated logger channel
  `logger.channel.advanced_filesystem_image_optimizer`.
- **Hook** `hook_file_presave` (`*.module`): runs `optimize()` on a matching newly saved file,
  guarded by a static recursion flag and a try/catch.
- **Drush** (`drush.services.yml` → `Commands\ImageOptimizerCommands`):
  `adfs:image-optimizer:run` (alias `adfs-opt`) and `adfs:image-optimizer:stats`
  (alias `adfs-opt-stats`).
- **Routes** (`*.routing.yml`, all `_permission: administer advanced_filesystem_image_optimizer`):
  `.settings` (`ImageOptimizerSettingsForm`), `.batch` (`ImageOptimizerBatchForm`),
  `.log` (`ImageOptimizerLogController::page`) under
  `/admin/config/media/advanced_filesystem/image-optimizer`.
- **Permission** `administer advanced_filesystem_image_optimizer` (restrict access).
- **Config** object `advanced_filesystem_image_optimizer.settings` (install defaults + schema):
  `enabled`, `mime_types`, `max_width`, `max_height`, `jpeg_quality`, `png_compression`,
  `convert_to_webp`, `webp_quality`, `strip_exif`, `skip_if_larger`.
- **DB table** `adfs_image_optimizer_log` (PK `fid`) — created via `hook_schema` / `hook_update_9001`.

## Mechanism (from source)

- `appliesToFile()` accepts only `image/*` MIME types, and if `mime_types` is non-empty only
  those listed.
- `optimize()` (throws if GD missing): loads via the MIME-matched `imagecreatefrom*`, downscales
  with `imagecopyresampled` when over `max_width`/`max_height` (never upscales), optionally writes
  a `.webp` copy, re-encodes into a `*.adfs_opt_tmp` buffer, and — when `skip_if_larger` and the
  result is not smaller and no resize happened — discards it; otherwise `rename()`s the temp over
  the original and updates the file size. Animated GIFs are detected (`isAnimatedGif`) and skipped.
- Savings are accumulated in State (`…total_savings`, `…optimized_count`); each file's outcome is
  `merge()`d into `adfs_image_optimizer_log` (`original_size`, `optimized_size`, `converted_webp`,
  `outcome`, `optimized_at`).

## Notes

- Purely local GD processing — **no external optimization API**, no network calls, no credentials.
- The Drush `run` command resolves FIDs from `file_managed` with parameterized conditions;
  `--field-name` is sanitised (`[^a-z0-9_]` stripped) and the field table's existence is checked
  before joining.
