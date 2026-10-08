# RIFT plugin types

RIFT defines two attribute-based plugin types plus a config-backed view-mode manager.

## `rift_source` — URL/output processors

- Manager: `plugin.manager.rift_source` (`RiftSourceManager`, extends `DefaultPluginManager`).
- Discovery dir: `Plugin/RiftSource`. Interface: `Drupal\rift\RiftSourceInterface`. Attribute:
  `Drupal\rift\Attribute\RiftSource` (`id`, `label`, `description`). Alter: `hook_rift_source_alter`.
- Job: turn an ordered list of image-style ids + a source URI into the final URL for one
  `<source>`/`srcset` candidate.

```php
// RiftSourceInterface
public function generate(array $input_styles, ?string $uri): string;
```

Bundled ids:

| id | Class | Behaviour |
|---|---|---|
| `combined_image_style` (default) | `CombinedImageStyle` | Chains the styles into one combined derivative; **auto-creates** missing `image.style.*` from `NNw`/`NNh`/extension tokens (`image_scale` / `focal_point_scale_and_crop` / `image_scale_and_crop` + `image_convert`). Returns a token-protected local derivative URL. |
| `dummyimage` | `DummyImage` | Returns a `https://dummyimage.com/{w}x{h}/…?text=…` URL (client-side external placeholder). |
| `placeholdco` | `Placeholdco` | Returns a `https://placehold.co/{w}x{h}?text=…` URL. |
| `placeholdit` | `Placeholdit` | Returns a `https://place-hold.it/{w}x{h}?text=…` URL. |

The three placeholder plugins only build a string URL used as an `<img>`/`<source>` `src`; they do
not fetch anything server-side.

## `rift_media_source` — input processors

- Manager: `plugin.manager.rift_media_source` (`RiftMediaSourceManager`).
- Discovery dir: `Plugin/RiftMediaSource`. Interface: `Drupal\rift\RiftMediaSourceInterface`.
  Attribute: `Drupal\rift\Attribute\RiftMediaSource`. Alter: `hook_rift_media_source_alter`.
- Job: given a media entity, provide the source image (`ImgElement` with uri/alt/title/width/height),
  validate it, and compute the "image boundary" image-style token for a transform.

```php
// RiftMediaSourceInterface
public function validateMedia($media): bool;
public function getImageData(?MediaInterface $media = NULL, ?SourceTransformConfig $transformConfig = NULL): ImgElement;
public function generateImageBoundaryStyle(MediaInterface $media, SourceTransformConfig $transformConfig): string;
```

Bundled ids:

| id | Class | Behaviour |
|---|---|---|
| `image` | `Image` (extends `ImageSourceBase`) | Reads the media's source image field. |
| `multiple_image` (install default) | `MultipleImage` (extends `ImageSourceBase`) | Like `image`, but per breakpoint prefers an optional `{source_field}_{screen}` field when present (art-direction). |
| `placeholder` | `Placeholder` | Ignores the media, returns a demo placeholder (`validateMedia()` always TRUE). |

`ImageSourceBase::generateImageBoundaryStyle()` returns `"{ar}-{w}w"` when a manual crop of type
`crop.type.{ar}` exists for the file (`Crop::cropExists()`), otherwise `"{w}w{h}h"` computed from the
aspect ratio.

## `rift_picture_view_modes` — view-mode definitions

`RiftPictureViewModes` extends `DefaultPluginManager` but uses `YamlDiscovery` for
`*.rift_picture_view_modes.yml` files, then **merges in** every entry of `rift.settings:view_modes`
(keyed by view-mode id, `id` added). So a RIFT "view mode" can come from either a YAML plugin file or
the `rift.settings` config. Definitions carry `label`, `sizes`, `aspect_ratios`, `attributes`,
`fallback_transform`. Cached with tag `rift_picture_view_modes` in `cache.discovery`. The formatters
list these as the selectable "Rift View mode" options.

## Supporting DTOs

`src/DTO/`: `PictureConfig` (parses raw config into typed state; the `process*()` builder methods),
`ScreenConfig` (`width`, `mediaQuery`), `SourceConfig`, `SourceTransformConfig` (per-candidate:
`size`, `screen`, `width`, `mediaQuery`, `aspectRatioStyle`, `transformStyle`, …).
