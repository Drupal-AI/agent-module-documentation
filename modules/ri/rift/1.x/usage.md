<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RIFT (Responsive Image Formatter Tools) generates responsive `<picture>`/`srcset` markup from media-reference fields and Twig, driven by reusable "responsive image view modes".

---

Install RIFT with Composer (`composer require drupal/rift`) — it pulls in its dependencies `image_widget_crop`, `image_style_quality`, `focal_point` and `crop` — then enable it with `drush en rift`. For a much better editing experience also enable the **RIFT UI** submodule (`drush en rift_ui`), which adds a Svelte configuration app at `/admin/config/media/rift/rift-ui` with validation and auto-healing; the deprecated `rift_starter_kit` submodule can pre-generate a starter configuration. Configuration lives in one config object, `rift.settings`, editable at `/admin/config/media/rift` (permission **Administer RIFT configuration**): you define **screens** (breakpoints as width + media query), a global default block (**multipliers** like `1x`/`2x`, **quality** per multiplier, **formats** such as `webp`/`jpeg`, extra attributes, a fallback image style) and named **view modes** (each with `sizes` and `aspect_ratios`). RIFT does not ship image styles — it generates the needed `image.style.*` and `crop.type.*` config on demand from templates. To display images, add a **media entity reference field** (image media) to your content, then on Manage Display choose the **Rift Media Picture** formatter (or **Rift Media Picture (with fallback)** to fall back to a normal media view mode for non-image bundles) and pick a Rift view mode. Developers can render markup directly in Twig with `{{ node.field_image.0.entity|rift_picture({ sizes: 'sm:100vw lg:50vw', aspect_ratios: '16x9 16x9' }) }}`. Pair it with `image_widget_crop`/`focal_point` for manual cropping and points of interest.

---

- Build responsive `<picture>` markup for content images without hand-writing image styles.
- Centralize a site-wide responsive image strategy in one `rift.settings` config object.
- Define reusable "responsive image view modes" (hero, teaser, etc.) with per-breakpoint sizes.
- Serve modern formats (WebP/AVIF) with graceful fallback to JPEG/PNG.
- Emit high-density `2x` srcset candidates with per-density quality settings.
- Apply art-directed crops per breakpoint via aspect-ratio-driven image styles.
- Use manual cropping (`image_widget_crop`) and focal points (`focal_point`) in responsive output.
- Format a media entity reference field as a responsive picture on Manage Display.
- Fall back to a standard media view mode for non-image media (video, SVG) with the fallback formatter.
- Generate responsive markup directly in Twig templates with the `rift_picture` filter.
- Configure everything through the RIFT UI app instead of editing YAML by hand.
- Pre-seed a working configuration quickly with the (deprecated) RIFT Starter Kit.
- Preview how a media item renders across every view mode via the RIFT UI media endpoint.
- Auto-generate the `image.style.*` and `crop.type.*` config a strategy needs.
- Extend URL generation with a custom `rift_source` plugin (e.g. a CDN or placeholder service).
- Swap the input side with a custom `rift_media_source` plugin (e.g. alternate image fields).
- Use placeholder image sources/services to prototype layouts before real content exists.
- Chain multiple image styles into a single token-protected derivative URL.
- Reduce layout shift by emitting width/height on generated images.
- Keep image markup cache-aware (per media entity plus RIFT settings).
- Restrict who can change the responsive image configuration via the admin permission.
