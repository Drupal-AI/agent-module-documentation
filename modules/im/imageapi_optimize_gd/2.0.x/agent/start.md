<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ImageAPI Optimize GD — agent index

Adds one **ImageAPI Optimize processor** — `id: imageapi_optimize_gd`, label **"GD"** — that
re-compresses **JPEG/WebP** image-style derivatives at a chosen quality using PHP's GD library.
No admin route, no permissions, no Drush, no config schema of its own (`configure: null`). All
state lives on the `imageapi_optimize_pipeline` config entity you add it to.

- **Add/configure the GD processor on a pipeline; where the quality is stored** →
  [configure/pipeline.md](configure/pipeline.md)
- **The processor plugin: id, label, defaults, applyToImage() behavior, MIME gating** →
  [plugins/gd-processor.md](plugins/gd-processor.md)

Key facts:
- Plugin type: `ImageAPIOptimizeProcessor` (provided by the parent `imageapi_optimize` module).
- Defaults: `quality: 75`, `file_types: ['image/jpeg']`. Options: quality 1–100; file types JPEG, WebP.
- Requires PHP GD (`imagegd2()`); otherwise it logs a notice and does nothing.
- Stored in the pipeline: `imageapi_optimize.pipeline.<id>` → `processors[]` with
  `id: imageapi_optimize_gd`, `data: {quality, file_types}`.
