# Webp service

Service **`webp.webp`** (`Drupal\webp\Webp`) — creates and manages WebP derivatives.

```php
$webp = \Drupal::service('webp.webp');

// Create a .webp copy of an image file (quality defaults to config webp.settings:quality).
$webp->createWebpCopy($uri, $quality = NULL);

// Rewrite a srcset string, replacing image URLs with their .webp equivalents.
$new_srcset = $webp->getWebpSrcset($srcset);

// Compute the .webp destination uri for a given source uri + filename template.
$dest = $webp->getWebpDestination($uri, $template);

// Delete all generated WebP image-style derivatives (e.g. on cache flush).
$webp->deleteImageStyleDerivatives();
```

Built on `@image.factory` (GD toolkit) and `@file_system`. Most callers don't invoke this
directly — it is used by the responsive-image preprocess and the download controllers (see
[../extend/integration.md](../extend/integration.md)).
