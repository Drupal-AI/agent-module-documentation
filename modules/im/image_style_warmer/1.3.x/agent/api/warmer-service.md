<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `image_style_warmer.warmer` service

Service id **`image_style_warmer.warmer`**, class `Drupal\image_style_warmer\ImageStylesWarmer`
(implements `ImageStylesWarmerInterface` and `DestructableInterface`; tagged
`needs_destruction`). Get it with `\Drupal::service('image_style_warmer.warmer')` or inject it.

## Methods (`ImageStylesWarmerInterface`)

| Method | What it does |
|---|---|
| `warmUp(FileInterface $file)` | Entry point used by the file hooks. Registers the file for **initial** warmup at request end (via `destruct()`), and if `queue_image_styles` is non-empty, queues those styles now. |
| `doWarmUp(FileInterface $file, array $image_styles)` | Immediately creates the given styles' derivatives for the file (skips ones that already exist). No-op if `$image_styles` is empty or the file fails image validation. |
| `addQueue(FileInterface $file, array $image_styles)` | Adds a `{file_id, image_styles}` item to the `image_style_warmer_pregenerator` queue (only for valid image files). |
| `validateImage(FileInterface $file)` | Returns FALSE for non-permanent files or files whose extension is not a supported image type; TRUE otherwise. |

`destruct()` (called automatically at kernel terminate) loops the files collected by `warmUp()`
and calls `doWarmUp()` with the configured `initial_image_styles`.

## How it is wired

`image_style_warmer.module` implements `hook_file_insert`, `hook_file_update`,
`hook_crop_insert`, `hook_crop_update` — each just calls `->warmUp($file)`. So any code that
saves a permanent image file (or a Crop entity referencing a file) triggers warming
automatically; you rarely call the service yourself.

## Programmatic use

```php
$file = \Drupal\file\Entity\File::load($fid);   // must be permanent
$warmer = \Drupal::service('image_style_warmer.warmer');

// Force specific styles right now (synchronous):
$warmer->doWarmUp($file, ['thumbnail', 'large']);

// Or queue them for cron:
$warmer->addQueue($file, ['large']);
```

## Queue worker

Plugin id **`image_style_warmer_pregenerator`** (`ImageStylesPregenerator`, a
`QueueWorkerBase` with `cron = {"time" = 60}`). `processItem($data)` loads the file by
`$data['file_id']` and calls `doWarmUp($file, $data['image_styles'])`. Run it with cron or
`drush queue:run image_style_warmer_pregenerator` (see [drush/commands.md](../drush/commands.md)).
