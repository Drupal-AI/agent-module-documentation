<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ImageOptimizerService — API, hook, config, Drush, log

## Install & enable

```bash
drush en advanced_filesystem_image_optimizer -y
```

Requires the base `advanced_filesystem` module and PHP **GD** (`ext-gd`). Optimization is **off
by default** (`enabled: false`) — turn it on at
`/admin/config/media/advanced_filesystem/image-optimizer`.

## Service: `advanced_filesystem_image_optimizer.optimizer` (`Service\ImageOptimizerService`)

Constructor args (`*.services.yml`): `@config.factory`,
`@logger.channel.advanced_filesystem_image_optimizer`, `@state`, `@database`.

| Method | Purpose |
|---|---|
| `isEnabled(): bool` | Reads `enabled` from config. |
| `appliesToFile(FileInterface $file): bool` | `image/*` and, if `mime_types` set, one of them. |
| `optimize(FileInterface $file): array` | Downscale + re-encode (+ optional WebP); returns `{original_size, optimized_size, savings, converted, skipped}`. Throws `\RuntimeException` if GD absent. |
| `isAlreadyOptimized(int $fid): bool` | True if a log row exists for the FID. |
| `getOptimizationLog(?int $fid=NULL, int $limit=50): array` | Log rows. |
| `getSavingsStats(): array` | `{total_savings, optimized_count}` from State. |
| `resetSavingsStats(): void` | Zero the counters. |

### `optimize()` flow

1. Throw if GD is not loaded. Read config (`max_width`, `max_height`, `jpeg_quality` 85,
   `png_compression` 6, `convert_to_webp`, `webp_quality` 80, `skip_if_larger`).
2. Require a real, readable, writable path. Skip animated GIFs (`isAnimatedGif` scans for
   multiple GIF image descriptors).
3. Load with the MIME-matched `imagecreatefrom{jpeg,png,webp,gif,avif}` (fallback
   `imagecreatefromstring`). Downscale with `imagecopyresampled` when over the max dimensions
   (never upscales, preserves alpha).
4. When `convert_to_webp` and not already WebP, write `<name>.webp` via `imagewebp`.
5. Re-encode into a `<realpath>.adfs_opt_tmp` buffer with `saveImage()` (per-MIME encoder).
6. When `skip_if_larger` and the temp is not smaller and no resize happened, delete the temp and
   record `skipped_larger`. Otherwise `rename()` the temp over the original, update
   `File::setSize()`, add to State savings, and record `optimized`.

## Hook (`*.module`)

`hook_file_presave` loads the service and, when `isEnabled()` and `appliesToFile()`, calls
`optimize($file)` inside a try/catch, guarded by a static per-FID flag to prevent recursion. The
optimizer mutates the file **in place** on save (overwrites the original bytes; a WebP copy is a
separate sibling file).

## Config object `advanced_filesystem_image_optimizer.settings`

Install defaults (`config/install/…settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `enabled` | `false` | Master switch. |
| `mime_types` | `image/jpeg\nimage/png\nimage/webp` | Newline list; empty = all `image/*`. |
| `max_width` / `max_height` | `0` | Max dimension in px (0 = unlimited). |
| `jpeg_quality` | `85` | JPEG re-encode quality (1–100). |
| `png_compression` | `6` | PNG compression level (0–9). |
| `convert_to_webp` | `false` | Write a `.webp` copy. |
| `webp_quality` | `80` | WebP quality (1–100). |
| `strip_exif` | `true` | Strip EXIF/IPTC during re-encode. |
| `skip_if_larger` | `true` | Keep the original when the re-encode is not smaller. |

## Drush (`Commands\ImageOptimizerCommands`)

- `adfs:image-optimizer:run` (alias `adfs-opt`) — bulk-optimize existing managed images. Options:
  `--mime`, `--field-name`, `--bundle` (requires `--field-name`), `--fid`, `--limit`,
  `--skip-optimized`, `--dry-run`. Resolves FIDs from `file_managed` (default filter
  `filemime LIKE image/%`), loads each file, and calls `optimize()` + `$file->save()`. Refuses to
  run when the optimizer is disabled.
- `adfs:image-optimizer:stats` (alias `adfs-opt-stats`) — prints total files optimized, total
  bytes saved, and the last ten log rows.

## DB table `adfs_image_optimizer_log`

PK `fid`; `original_size`, `optimized_size`, `converted_webp` (tiny), `outcome`
(`optimized | skipped_larger | skipped_animated | error`), `optimized_at` (indexed on
`optimized_at`, `outcome`). Created on install (`hook_schema`) and for existing sites via
`hook_update_9001` (`drush updb`). The log page (`ImageOptimizerLogController::page`) shows a
stats bar, an outcome filter and a paginated table.
