<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# The `resmushit` processor plugin

This module provides a **single plugin** of the `ImageAPIOptimizeProcessor` plugin type
(the type itself is defined by the required **imageapi_optimize** module, not here).

| | |
|---|---|
| Plugin type | `ImageAPIOptimizeProcessor` (annotation discovery) |
| Plugin id | **`resmushit`** |
| Class | `Drupal\imageapi_optimize_resmushit\Plugin\ImageAPIOptimizeProcessor\ReSmushit` |
| Base | `ConfigurableImageAPIOptimizeProcessorBase` (from imageapi_optimize) |
| Label | "Resmush.it" |
| Settings | `quality` — integer 1–100 ("JPEG image quality"); default `NULL` (unset) |

Config schema (`imageapi_optimize.processor.resmushit`): a mapping with one key,
`quality` (integer).

## How it is stored

A processor instance is **not** a standalone config entity. It lives inside an
`imageapi_optimize_pipeline` entity's `processors` array, keyed by a generated UUID:

```yaml
# excerpt of imageapi_optimize.pipeline.<name>
processors:
  aeff9759-4bda-44b6-8a2a-6266253522d1:
    id: resmushit          # the plugin id
    data:
      quality: 80          # the one setting (omit / null = no qlty sent)
    weight: 0
    uuid: aeff9759-4bda-44b6-8a2a-6266253522d1
```

Adding a `resmushit` processor to a pipeline makes the pipeline depend on the
`imageapi_optimize_resmushit` module (recorded in `dependencies.module`).

## Runtime behaviour (`applyToImage($image_uri)`)

1. Builds a multipart POST: field `files` = the image stream, and — **only if `quality` is
   set** — field `qlty` = the quality value.
2. POSTs to `http://api.resmush.it/ws.php` via the `http_client` service.
3. Reads `dest` from the JSON response, GETs that optimized file, and overwrites the local
   file (`file_system` `saveData`, EXISTS_REPLACE). Returns `TRUE` on success.
4. On a `RequestException` it logs to the **`imageapi_optimize`** logger channel and returns
   `FALSE`; the original image is left in place.

So optimization requires a working outbound call to the reSmush.it service — there is no
local/offline mode. Verify configuration against the pipeline entity, not a live run.
