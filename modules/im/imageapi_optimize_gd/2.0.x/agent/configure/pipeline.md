<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: add GD to an Image Optimize pipeline

The module has **no settings page** (`configure: null`). You configure it by adding the GD
processor to an ImageAPI Optimize **pipeline**, then applying that pipeline to image styles.

## Via the UI
1. *Configuration → Media → Image Optimize pipelines*
   (`/admin/config/media/imageapi-optimize-pipelines`). Add a pipeline (give it a label/name).
2. On the pipeline edit form, "Select a new processor" → **GD** → **Add**.
3. Set **Image quality** (1–100) and tick the **File Types** (JPEG and/or WebP) → **Add processor** / Save.
4. Optionally set a **Sitewide default pipeline** on the pipelines overview (writes
   `imageapi_optimize.settings:default_pipeline`).
5. Apply per style: *Configuration → Media → Image styles* → edit a style → choose the pipeline
   (or "Sitewide default pipeline") at the bottom → Save. Flush the style to recompress existing derivatives.

## Where it is stored
Pipeline config entity `imageapi_optimize.pipeline.<id>` (entity type
`imageapi_optimize_pipeline`, `config_prefix: pipeline`):
```yaml
name: my_pipeline
label: 'My pipeline'
processors:
  - id: imageapi_optimize_gd
    data:
      quality: 60
      file_types:
        image/jpeg: image/jpeg
        image/webp: image/webp
    weight: 0
    uuid: ...
```
Sitewide default: `imageapi_optimize.settings` → `default_pipeline: <pipeline_id>`.

## Via drush (programmatic)
```php
\Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline::create([
  'name' => 'my_pipeline', 'label' => 'My pipeline',
  'processors' => [[
    'id' => 'imageapi_optimize_gd', 'weight' => 0, 'uuid' => \Drupal::service('uuid')->generate(),
    'data' => ['quality' => 60, 'file_types' => ['image/jpeg' => 'image/jpeg']],
  ]],
])->save();
```
Recommended: keep the sitewide **GD toolkit** quality at 100% and let the pipeline own quality,
so compression stays separate from crop/scale/overlay effects.
