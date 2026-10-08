<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Combined image style (combined_image_style) — agent index

A **drop-in replacement for core's image-style derivative system** that renders **one derivative
image from the combined effects of several image styles**. Instead of one folder segment naming a
single style, the derivative path names a **hyphen-joined list of style ids** (`square-thumbnail`);
the module merges every listed style's image effects, in order, into a single pipeline and writes
one derivative. Both the combined system and core's normal per-style system keep working side by
side. Package `Image`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. Installed **1.0.6**
(version dir `1.0.x`). Declares **no permissions, no routes of its own, no config, no drush**.

Motivating example (from the project page): cropping styles `portrait`/`square`/`landscape` × sizing
styles `thumbnail`/`medium`/`large` normally means 9 combined styles; here you keep the 6 building
blocks and combine them on demand (`square-large`, `portrait-thumbnail`, …).

## How it hooks into core (from source)

- **Entity class swap** — `Hook\EntityHooks::entityTypeBuild()` (`#[Hook('entity_type_build')]`)
  replaces the `image_style` entity class with `combined_image_style\Entity\ImageStyle` (a subclass
  of core's `ImageStyle`). This overrides `postSave()`/`flush()` so that flushing a normal style also
  flushes every combined style that references it (found by scanning the `styles/` derivative dirs).
- **Route override** — `Routing\RouteSubscriber` (event subscriber, priority `-1025`) rewrites the
  core `image.style_public` route: path segment `image_style` → `image_styles`, and the controller to
  `Controller\ImageStyleDownloadController::deliverCombined`. That controller extends core's
  `ImageStyleDownloadController` and just wraps `deliver()` with a `CombinedImageStyle::fromName()`
  entity built from the hyphen-joined path segment. **The core itok token check is inherited
  unchanged** — see the routing doc.
- **Theme hook** — `Hook\ThemeHooks::theme()` registers `combined_image_style_responsive_image`
  (variables `sources`, `image`), rendered by `templates/combined-image-style-responsive-image.html.twig`
  (a `<picture>` with `<source>` per breakpoint). Used only by the formatters submodule.
- **`combined_image_style.module`** — thin `#[LegacyHook]` shims delegating to the two Hook classes
  (Drupal 11 OOP hooks + procedural fallback). `services.yml` also declares a custom
  `cache.image_dimensions` cache bin used to memoize computed derivative dimensions.

`combined_image_style.info.yml` declares **no `dependencies:`**, but the module extends
`Drupal\image\*` classes, so core's **Image** module must be enabled.

## The `CombinedImageStyle` API (developer entry point)

`Entity\CombinedImageStyle` extends the (overridden) `ImageStyle`. Fluent, not a stored config
entity — you build one in memory:

```php
use Drupal\combined_image_style\Entity\CombinedImageStyle;

// Render array for the combined derivative.
(new CombinedImageStyle())
  ->setSourceUri($uri)
  ->setImageStyles(['square', 'thumbnail'])
  ->toImage();

// Just the derivative URI / URL (generate on demand).
(new CombinedImageStyle())->setSourceUri($uri)->setImageStyles(['square', 'large'])->buildCombinedUri();
(new CombinedImageStyle())->setSourceUri($uri)->setImageStyles(['square', 'large'])->buildCombinedUrl();
```

Its `id()` is the hyphen-joined list of the loaded styles' ids (that string is the `styles/` folder
name and what `deliverCombined` parses back with `fromName()`). Effects come from
`getEffects()` — every listed style's effect configs merged in order into one
`ImageEffectPluginCollection`.

## Solution docs

- **`CombinedImageStyle` entity: fluent API, id/folder scheme, effect merging, dimensions cache,
  flush cascade** → [api/combined-image-style.md](api/combined-image-style.md)
- **Route override, `deliverCombined` controller, itok token model, `getPathToken()`** →
  [routing/derivative-delivery.md](routing/derivative-delivery.md)

## Submodule

- **Combined image style formatters** (`combined_image_style_formatters`) — responsive `<picture>`
  field formatters for image and media fields, requires `drupal:responsive_image`. Documented at
  [modules/combined_image_style_formatters/1.0.x/agent/start.md](modules/combined_image_style_formatters/1.0.x/agent/start.md).
