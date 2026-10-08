<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add binary processors to a pipeline, and select a pipeline

This module has **no configure route of its own**. Optimization is configured on the parent
`imageapi_optimize` module's *pipeline* entities (`imageapi_optimize_pipeline`), which store a
list of processors. The binary processors documented here are just plugin ids you add to that
list.

## The config entity

`imageapi_optimize.pipeline.<name>` (entity type `imageapi_optimize_pipeline`):

```yaml
name: local_binaries
label: 'Local Binaries'
processors:
  <uuid>:
    id: jpegoptim            # a processor plugin id
    weight: 4
    uuid: <uuid>
    data:                    # the processor's own settings (see plugins/processors.md)
      manual_executable_path: ''
      progressive: 1
      quality: 80
      size: ''
```

## Shipped pipeline

Enabling the module installs the optional pipeline `imageapi_optimize.pipeline.local_binaries`
(label **Local Binaries**) containing all nine processors ordered advdef → advpng → jfifremove
→ jpegoptim → jpegtran → optipng → pngcrush → pngout → pngquant. Inspect it with:

```bash
drush cget imageapi_optimize.pipeline.local_binaries
```

## Select a pipeline

- **Site default** — `imageapi_optimize.settings:default_pipeline` (ships as `null`):
  ```bash
  drush cset imageapi_optimize.settings default_pipeline local_binaries -y
  ```
- **Per image style** — an image style can name a pipeline; set it on the style's edit form
  or in `image.style.<style>` config (the parent module adds the "Optimization pipeline"
  selector to image styles).

## Create/edit via UI

Admin UI (from the parent module): *Configuration → Media → Image Optimize pipelines*
(`/admin/config/media/imageapi-optimize-pipelines`). Add a pipeline, then **Add processor**,
pick e.g. *JpegOptim*, set its options, Save.

## Create a pipeline in code / drush

```php
$p = \Drupal::entityTypeManager()->getStorage('imageapi_optimize_pipeline')->create([
  'name' => 'my_pipeline', 'label' => 'My pipeline',
]);
$p->addProcessor([
  'id' => 'optipng', 'weight' => 1,
  'data' => ['manual_executable_path' => '', 'level' => 7, 'interlace' => ''],
]);
$p->save();
```

`addProcessor()` assigns a uuid automatically. Read back with `drush cget
imageapi_optimize.pipeline.my_pipeline processors`.
