<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Optimize - Binaries — agent index

Supplies nine `ImageAPIOptimizeProcessor` plugins that optimize image-style derivatives by
running local CLI binaries. It has **no config UI of its own** (`configure: null`) — the UI is
the parent `imageapi_optimize` module's *pipeline* forms. You add these processors to an
`imageapi_optimize_pipeline` config entity, then point an image style (or the site default) at
that pipeline.

- **The nine processors: ids, binaries, and their settings keys** →
  [plugins/processors.md](plugins/processors.md)
- **Add a processor to a pipeline / the shipped `local_binaries` pipeline / set the default
  pipeline (config keys, drush)** → [configure/pipeline.md](configure/pipeline.md)
- **The `shell_operations` service + `ImageAPIOptimizeProcessorBinaryBase` (how a binary is
  located and executed; write your own binary processor)** → [api/shell-operations.md](api/shell-operations.md)
- **The one permission (`configure imageapi_optimize_binary paths`)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Processor plugin ids: `advdef`, `advpng`, `jfifremove`, `jpegoptim`, `jpegtran`, `optipng`,
  `pngcrush`, `pngout`, `pngquant`.
- Pipelines are config entities `imageapi_optimize.pipeline.<name>` (entity type
  `imageapi_optimize_pipeline`); processors are stored under `processors.<uuid>` with
  `{id, weight, uuid, data:{…}}`.
- Shipped pipeline: `imageapi_optimize.pipeline.local_binaries` (label "Local Binaries"), all
  nine processors. Site default is `imageapi_optimize.settings:default_pipeline` (ships `null`).
- A processor only acts if its binary exists on the server; otherwise it is a silent no-op.
