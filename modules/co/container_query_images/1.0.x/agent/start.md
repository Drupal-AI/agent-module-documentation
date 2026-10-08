<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Container Query Images (container_query_images) — agent index

info.yml name **"Container Query Images"**, version **1.0.2** (version-dir 1.0.x). Package **Media**.
Extends core **Responsive Image** so `<picture>` images pick their variant from their **container's**
width (CSS container queries + a `ResizeObserver`) instead of the viewport width — correct sizing when
one component appears in different-width regions (sidebar card vs. wide-column card). Depends on core
`image`, `responsive_image`, `breakpoint`. Core `^10.2 || ^11`. License GPL-2.0-or-later.

**No settings UI, no routes, no permissions, no config entities, no Drush, no config schema.** You
operate it entirely through the core Responsive Image workflow. It is activated purely by a naming
convention: any responsive image style whose **breakpoint group name contains the substring
"container"** (case-insensitive), plus the module's own bundled group `container_query_images`.

## What it actually ships

- **`src/Hook/ContainerQueryImagesHooks.php`** — one final service class (registered in
  `container_query_images.services.yml`, arg `@entity_type.manager`) holding all logic via `#[Hook]`
  attributes (Drupal 10.2+). `.module` keeps thin `#[LegacyHook]` procedural wrappers that delegate to
  it (so on Drupal 11.1+ only the attribute impl runs).
  - `#[Hook('help')] help()` — help page text only (route `help.page.container_query_images`).
  - `#[Hook('preprocess_responsive_image')] preprocessResponsiveImage(&$variables)` — the core.
- **`container_query_images.breakpoints.yml`** — 6 ready-to-use breakpoints in group
  `container_query_images`: SM 240px, MD 480px, LG 720px, XL 960px, 2XL 1200px, 3XL 1440px, each with
  `1x`+`2x` multipliers.
- **`container_query_images.libraries.yml`** — library `container_query_images` (css component +
  `js/container-query-images.js`, dep `core/drupal`).
- **`css/container-query-images.css`** — `.cq-image-wrapper { container-type: inline-size;
  container-name: image-container }` + `@supports not` fallback.
- **`js/container-query-images.js`** — `Drupal.behaviors.containerQueryImages`, `ResizeObserver`-driven
  variant selection.

## Mechanism (from source)

`preprocessResponsiveImage()`:
1. Reads `$variables['responsive_image_style_id']`; returns early if empty or the style entity fails to
   load (`entity_type.manager` → `responsive_image_style` storage).
2. `isContainerGroup($style->getBreakpointGroup())` — TRUE if the group is exactly
   `container_query_images` OR `stripos($group, 'container') !== FALSE`. Otherwise returns (native
   viewport `<picture>` behavior, untouched).
3. Container mode: attaches library `container_query_images/container_query_images`, adds class
   `cq-image-wrapper` to the wrapper attributes.
4. For each `$variables['sources']`: `extractWidth($source['media'])` parses `min-width`/`max-width` px
   (em/rem × 16), stores it as integer `data-cq-min-width`, then `unset($source['media'])` so the
   browser does not do native media matching.
5. Unsets the `<img>` fallback `srcset`; sets `$variables['is_container_query'] = TRUE`.

`js`: `parseSrcset()` handles both `800w` width descriptors and `1x/2x` density descriptors.
`updateContainerQueryImage()` measures `wrapper.offsetWidth`, picks the largest `data-cq-min-width`
source that still fits (fallback: smallest), then sets the `<img>` `src`/`srcset`/`sizes` (width mode
uses `containerWidth * devicePixelRatio`; density mode defers to the browser). Runs on a
`ResizeObserver`, with a debounced `window.resize` fallback where `ResizeObserver` is absent.

## Operating it

See the human guide in `../human-docs/` and `../usage.md`. Quick path: create a responsive image style
on the bundled `container_query_images` group (or any custom theme breakpoint group whose name contains
"container"), map image styles per breakpoint, then use the **standard core Responsive Image formatter**
on the field's Manage display — container-query mode switches on automatically. Requires a
container-query-capable browser (Chrome 105+, Safari 16+, Firefox 110+); older browsers use the JS
`ResizeObserver` path.
