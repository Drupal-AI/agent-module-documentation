<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a WebP pipeline

WebP output is configured through **ImageAPI Optimize pipelines** (owned by `imageapi_optimize`);
this module only adds the "WebP Deriver" processor to choose from. No settings page of its own.

## Via the UI

1. *Configuration → Media → Image Optimize pipelines*
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. Add a pipeline (name it). In "Select a new processor" choose **WebP Deriver**, click **Add**,
   set the **Image quality** (percentage, default 75), then **Add processor** and save.
3. Optionally set it as the **Sitewide default pipeline** on that page, or
4. Assign it to an individual image style at *Configuration → Media → Image styles* → edit style →
   choose the pipeline at the bottom.

## Via config / drush (scriptable)

Pipelines are `imageapi_optimize_pipeline` config entities. The processor lives in the `processors`
list keyed by a uuid:

```php
use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
use Drupal\Component\Uuid\Php as Uuid;

$uuid = \Drupal::service('uuid')->generate();
ImageAPIOptimizePipeline::create([
  'name' => 'iow_pipe',                 // NB: the id key is 'name'
  'label' => 'WebP pipeline',
  'processors' => [
    $uuid => [
      'id' => 'imageapi_optimize_webp',
      'data' => ['quality' => 80],
      'weight' => 0,
      'uuid' => $uuid,
    ],
  ],
])->save();
```

Assign a pipeline to an image style (imageapi_optimize adds `pipeline` to image styles):

```php
$style = \Drupal\image\Entity\ImageStyle::load('thumbnail');
$style->setThirdPartySetting('imageapi_optimize', 'pipeline', 'iow_pipe'); // or $style->set('pipeline', 'iow_pipe')
$style->save();
```

Read back:

```bash
drush cget imageapi_optimize.pipeline.iow_pipe processors
```

Or in PHP, check a pipeline has the WebP processor:

```php
foreach (ImageAPIOptimizePipeline::load('iow_pipe')->getProcessors() as $p) {
  if ($p->getPluginId() === 'imageapi_optimize_webp') { /* found */ }
}
```

## Notes

- The processor's `quality` is stored per pipeline in the processor's `data`.
- The site-wide default pipeline is stored in `imageapi_optimize.settings`.
