<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Carousel (easy_carousel) — agent index

**Entity-driven carousel/slider builder: reusable Carousel + Carousel Slide content entities rendered by four configurable block plugins (Simple, Bootstrap, Brands, Gallery).**

- **Version:** 2.0.x (release 2.0.0, 2025-05-04)
- **Core:** ^11
- **Depends:** field, media (core). Slide fields also use the core `link` type.
- **Package:** Custom
- **License:** GPL-2.0-or-later
- **Maintainer:** Jorge Pérez (xurdep)

## What it is

Not a field formatter or a Layout Builder component. It defines two custom content entity types and renders them through blocks:

- **`carousel`** ("Carousel") — an ordered collection; base fields: `label`, `status`, `items` (unlimited entity_reference to `carousel_item`), `uid`. Revisionable, translatable. Managed at `/admin/content/carousel`.
- **`carousel_item`** ("Carousel Slide") — one slide. Fields include `label` (title), `media` (ref to Media: image/video/remote_video), `base64_image`, `external_image` (link), `video_options`, `description` (text_long), `link` + `link_target`, `item_background` + `background_opacity`, `title_color`, `description_color`, `text_alignment`, `text_position`, `show_title`, `status`. Revisionable, translatable. Managed at `/admin/content/carousel-item`.

A **block** (one of four) selects a Carousel via entity autocomplete and adds per-instance display options; `build()` attaches the matching library + a JSON-encoded `drupalSettings.easy_carousel[<id>].config` blob and renders the matching Twig template.

## Surface map

- **Blocks:** `simple_carousel_block`, `bootstrap_carousel_block`, `brands_carousel_block`, `gallery_carousel_block` (category "Easy Carousel Blocks"). All extend `CarouselBaseBlock`. `getCacheMaxAge()` = 0. See `blocks/carousel-blocks.md`.
- **Entities / content model:** see `entities/content-model.md`.
- **Permissions:** `administer carousel`, `administer carousel_item` (both `restrict access: true`).
- **Routes:** entity CRUD + settings (`admin/structure/carousel`, `admin/structure/carousel-item`, `administer carousel*`); `easy_carousel.export_form` and `easy_carousel.import_form` (`administer site configuration`). See `import-export.md`.
- **Libraries:** `simple`, `bootstrap`, `brands`, `gallery` — all CSS/JS bundled locally under `css/` and `js/` (Bootstrap type uses a customized local Bootstrap 5 build). No CDN, no external runtime services.
- **Services:** `easy_carousel.video_utils` (YouTube/Vimeo URL → embed URL) exposed to Twig as `embed_url()` via `EasyCarouselTwigExtension`.
- **Field widget:** `color_widget` (HTML `<input type="color">` over a `string` field).
- **Templates:** `carousel-simple`, `carousel-bootstrap`, `carousel-brands`, `carousel-gallery`.

## Key facts for agents

- Slider options reach JS through `drupalSettings` (Drupal JSON-encodes → safe context).
- All rendering libraries are local; there is no third-party network dependency at runtime.
- Import is **destructive**: it deletes ALL existing carousels and slides before creating the imported ones.
- The `remote_video` bundle is embedded in a sandboxed `<iframe>` (`sandbox="allow-scripts allow-same-origin allow-presentation allow-popups"`).
- Entity ownership hooks: `hook_user_cancel` / `hook_user_predelete` unpublish/anonymize/delete a user's carousels and slides.
