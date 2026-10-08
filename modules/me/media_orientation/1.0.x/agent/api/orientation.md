<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: Orientation mapping & detection

Two small, unversioned helper classes in `Drupal\media_orientation`. There is no service — they are
instantiated/called directly.

## `Orientation` (final)
Canonical value ↔ label mapping.

| Member | Value |
|---|---|
| `Orientation::LANDSCAPE` | `1` |
| `Orientation::PORTRAIT` | `2` |
| `Orientation::SQUARE` | `3` |
| `Orientation::getLabel(int $orientation): ?string` | Returns `'Landscape'` / `'Portrait'` / `'Square'`, or `NULL` for any other value. |

```php
use Drupal\media_orientation\Orientation;
$word = Orientation::getLabel($media->get('field_orientation')->value); // e.g. "Portrait"
```
Note: `getLabel()` returns the raw English string (untranslated); callers wrap it in `t()` when
displaying.

## `OrientationHelper`
Detection logic used by the presave hook.

| Method | Behavior |
|---|---|
| `determineOrientation(int $width, int $height): void` | Sets internal orientation: `width > height` → LANDSCAPE; `width == height` → SQUARE; else PORTRAIT. |
| `saveMediaEntityOrientation(EntityInterface $entity): void` | Full flow for a media entity: image-source check, reads the `media_orientation.orientation` third-party setting, verifies the target field is `list_integer`, loads the source file, runs `getimagesize()`, and `->set()`s the computed value on the entity. No-ops (early return) if any precondition is unmet. |

```php
use Drupal\media_orientation\OrientationHelper;
$helper = new OrientationHelper();
$helper->saveMediaEntityOrientation($mediaEntity); // called for you on media presave
```

The presave hook (`media_orientation_media_presave` in `media_orientation.module`) does exactly this
for every media entity save, so integrating usually means just configuring the field — see
[../configure/orientation.md](../configure/orientation.md).
