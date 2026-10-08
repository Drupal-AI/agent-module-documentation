<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Detection service: `AnimatedGif`

Service class `Drupal\animated_gif\Service\AnimatedGif`, aliased from the interface
`Drupal\animated_gif\Service\AnimatedGifInterface` (autowired). Inject the **interface** to use it.

```php
$svc = \Drupal::service(\Drupal\animated_gif\Service\AnimatedGifInterface::class);
$svc->isFileAnAnimatedGif($file);   // (FileInterface) -> bool
$svc->isAnAnimatedGif($file_uri);   // (string uri)   -> bool
```

## `isFileAnAnimatedGif(FileInterface $file): bool`

- Returns FALSE immediately unless `$file->getMimeType() === 'image/gif'`.
- Otherwise delegates to `isAnAnimatedGif($file->getFileUri())`.

## `isAnAnimatedGif(string $fileUri): bool`

- Logs an error and returns FALSE if the file does not exist.
- Reads the file in 100 KB chunks and counts GIF **frame headers** using the regex
  `#\x00\x21\xF9\x04.{4}\x00[\x2C\x21]#s` (the graphic-control-extension + image/extension
  separator that precedes each frame).
- Stops once it has found `MINIMUM_NUMBER_OF_ANIMATED_FRAMES` (= **2**) frames.
- Returns TRUE when the count is **> 1** — i.e. the GIF has at least two frames (is animated).

So: an animated GIF = an `image/gif` file with ≥2 frames. A single-frame (static) GIF, or any
non-GIF, is not animated. This is what every render path in the module (formatter + preprocess
hooks) uses to decide whether to bypass image styles.
