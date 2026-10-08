<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: the derivative warmer service

## Service

`image_styles_generator.derivative_warmer` — class
`Drupal\image_styles_generator\DerivativeWarmer`, implements `DerivativeWarmerInterface`.
Constructor arg: `@logger.channel.image_styles_generator`.

### Interface

```php
public function regenerateImageStyleDerivativeFromFile(
  \Drupal\image\ImageStyleInterface $image_style,
  \Drupal\Core\Entity\EntityInterface $file        // a File entity
): string;                                          // returns the derivative URI
```

Implementation is a thin wrapper over Drupal core:

```php
$derivative_uri = $image_style->buildUri($file->getFileUri());
$image_style->createDerivative($file->getFileUri(), $derivative_uri);
return $derivative_uri;
```

So warming a single file/style pair from custom code is:

```php
$warmer = \Drupal::service('image_styles_generator.derivative_warmer');
$file   = \Drupal::entityTypeManager()->getStorage('file')->load($fid);
$style  = \Drupal::entityTypeManager()->getStorage('image_style')->load('large');
$uri    = $warmer->regenerateImageStyleDerivativeFromFile($style, $file);
```

The Drush command (`ImageStylesGeneratorCommands`) also depends on `@entity_type.manager`
to load the `file` and `image_style` storages and to query all image files.

## How the WebP submodule overrides it

`image_styles_generator_webp` does **not** register a new command. It ships a
`ServiceProvider` (`ImageStylesGeneratorWebpServiceProvider::alter()`) that rewrites the
existing `image_styles_generator.derivative_warmer` definition to class
`DerivativeWebpWarmer` and appends a `@webp.webp` argument. That subclass calls
`parent::regenerateImageStyleDerivativeFromFile()` (normal derivative) then
`$this->webp->createWebpCopy($derivative_uri)`. Because it decorates the same service ID,
the unchanged Drush command transparently emits WebP copies once the submodule is enabled.
