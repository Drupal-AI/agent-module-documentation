<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Put reSmush.it in a pipeline and set its quality

The `resmushit` processor is always used **inside** an `imageapi_optimize_pipeline` config
entity (provided by the required imageapi_optimize module). Steps: create/pick a pipeline →
add the reSmush.it processor with a `quality` → attach the pipeline to image style(s).

Admin permission for the pipeline UI: **`administer imageapi optimize pipelines`**.

## A. Admin UI

1. Go to **Admin → Config → Media → Image Optimize pipelines**
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. **Add pipeline** (or edit one), give it a label/machine name, save.
3. On the pipeline, **Add a new processor → Resmush.it**.
4. Set **JPEG image quality** (1–100), or leave blank to send no quality. Save.
5. Attach the pipeline to an image style (imageapi_optimize integrates each style with a
   pipeline) so its derivatives get optimized.

## B. Drush / PHP (programmatic)

`ImageAPIOptimizePipeline::addProcessor()` generates the UUID and appends the instance:

```php
use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;

$pipeline = ImageAPIOptimizePipeline::create([
  'name'  => 'resmush_default',
  'label' => 'reSmush default',
]);
// id = the plugin id; the setting goes under data; weight orders multi-step pipelines.
$pipeline->addProcessor([
  'id'     => 'resmushit',
  'data'   => ['quality' => 80],
  'weight' => 0,
]);
$pipeline->save();
```

Run it with:

```bash
drush php:eval '<the code above>'
```

## C. Config YAML

`imageapi_optimize.pipeline.resmush_default.yml`:

```yaml
langcode: en
status: true
dependencies:
  module:
    - imageapi_optimize_resmushit
name: resmush_default
label: 'reSmush default'
processors:
  11111111-1111-4111-8111-111111111111:
    id: resmushit
    data:
      quality: 80
    weight: 0
    uuid: 11111111-1111-4111-8111-111111111111
```

Import with `drush config:import --partial --source=...` (or place under a module's
`config/install`). The `processors` key is keyed by the same UUID used in each instance.

## Inspecting an existing pipeline

```bash
# list pipelines
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->loadMultiple() as $p) { print $p->id()."\n"; }'

# read one pipeline's processors (ids + quality)
drush cget imageapi_optimize.pipeline.resmush_default processors
```

> Reminder: a live optimize run calls the external reSmush.it API. To confirm setup
> deterministically, assert the pipeline's `processors` contains an `id: resmushit` entry
> with the expected `data.quality` — do not depend on the remote service.
