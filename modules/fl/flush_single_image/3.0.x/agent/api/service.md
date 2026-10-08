# Service: `flush_single_image`

`Drupal\flush_single_image\FlushSingleImage` (implements `FlushSingleImageInterface`).
Constructor args: `@entity_type.manager`, `@file_system`, `@config.factory`.

Every UI, Drush command, action plugin and migrate plugin in the module ultimately calls this
service. Get it with `\Drupal::service('flush_single_image')` or inject the id `flush_single_image`.

## Action constants

| Constant | Value | Meaning |
|---|---|---|
| `FlushSingleImage::ACTION_UNLINK` | `1` | Delete (`unlink`) each existing derivative file. Core lazily regenerates it on next request. Default. |
| `FlushSingleImage::ACTION_REGENERATE` | `2` | Rebuild each derivative immediately via `ImageStyle::createDerivative()`. |

Passing any other int to `flush()`/`flushStyle()` throws `\InvalidArgumentException`.

## Methods

```php
// Flush the derivatives of $path across ALL image styles that currently have one.
// Returns map [style_id => flushed_derivative_uri] of the derivatives it acted on.
public function flush(string $path, int $action = self::ACTION_UNLINK): array;

// Flush the derivative of $path for ONE style only. Returns TRUE/FALSE.
public function flushStyle(string $path, string $image_style, int $action = self::ACTION_UNLINK): bool;

// Discover which styles currently have a cached derivative for $path.
// Returns map [style_id => derivative_uri]. Read-only; deletes nothing.
public function getStylePaths(string $path): array;
```

`$path` is the **source** image (e.g. `public://assets/foo/bar/image.jpg`), not a derivative
path. A path with no stream scheme is prefixed with `system.file:default_scheme` (default `public`)
and its leading `/` stripped, then resolved.

## What happens at runtime

`getStylePaths()` loads every `image_style` entity and, for each, computes the derivative URI with
core `ImageStyle::buildUri($path)` — always of the form `{scheme}://styles/{style_id}/{scheme}/{target}`.
A style is included only if that derivative file actually exists on disk (`is_file()` +
`file_exists()`). It also detects a sibling `.webp` derivative (same dir/filename, `.webp`
extension) so WebP variants are flushed too.

`flush()` iterates those results: for `ACTION_UNLINK` it calls `FileSystem::unlink($derivative_uri)`;
for `ACTION_REGENERATE` it calls `ImageStyle::load($style_id)->createDerivative($path, $derivative_uri)`.
`flushStyle()` does the same but only for the matching `$image_style` id.

## Example

```php
$path = 'public://assets/foo/bar/image.jpg';
/** @var \Drupal\flush_single_image\FlushSingleImage $svc */
$svc = \Drupal::service('flush_single_image');

// See what is cached first.
$cached = $svc->getStylePaths($path);           // [ 'thumbnail' => 'public://styles/thumbnail/public/assets/...' , ... ]

// Delete every derivative for this file.
$flushed = $svc->flush($path);                    // ACTION_UNLINK

// Or rebuild only the 'large' derivative right now.
$svc->flushStyle($path, 'large', FlushSingleImage::ACTION_REGENERATE);
```
