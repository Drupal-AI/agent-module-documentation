<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ImageAPI Optimize WebP — agent index

Adds a **"WebP Deriver"** processor to ImageAPI Optimize (Image Optimize): added to a pipeline it
creates a `.webp` copy of each styled image and serves it. Requires `imageapi_optimize`. No settings
form, no `configure` route, no permissions, no Drush of its own. Ships submodule
`imageapi_optimize_webp_responsive`.

- **The `imageapi_optimize_webp` processor plugin (WebP Deriver) + its `quality` setting** →
  [plugins/webp-processor.md](plugins/webp-processor.md)
- **Set it up: create a pipeline with the processor, assign to styles / sitewide default** →
  [configure/pipeline.md](configure/pipeline.md)
- **How WebP is generated and served (pipeline wrapper, route override, flush)** →
  [api/serving.md](api/serving.md)

Key facts: processor plugin id `imageapi_optimize_webp` (label "WebP Deriver"), config `quality`
(default 75, 1–100). Pipelines are `imageapi_optimize_pipeline` config entities owned by
`imageapi_optimize`. Submodule `imageapi_optimize_webp_responsive` adds WebP `<source>`s to core
responsive images. See its own docs under `modules/imageapi_optimize_webp_responsive/`.
