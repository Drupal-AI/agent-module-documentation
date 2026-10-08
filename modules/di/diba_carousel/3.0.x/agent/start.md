<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diba Carousel Slider (diba_carousel) — agent index

A single **block plugin** (`diba_carousel`) that renders a Bootstrap carousel/slider straight
from a fieldable entity type's own fields — no slide content type, no view, no Entityqueue. You
place the block, then pick the entity type, filter/sort the content, and map fields to
image / title / description / link. Slide data and all styling options live in the block
instance's own configuration.

- Dependencies: core only — `block`, `user`, `node`, `image`, `options`, `link`.
- Core: `^9.5 || ^10 || ^11`. No composer requirements beyond `drupal/core`.
- **No settings route** (`configure` is null), no permissions of its own, no services, no drush.
  Everything is done from the block-layout UI, gated by core's `administer blocks`.

## Solutions
- **Understand / operate the carousel block (build pipeline, entity query, image strategies, filter tokens)** → [blocks/diba_carousel.md](blocks/diba_carousel.md)
- **Every block-config key, its default and meaning; set config via PHP/drush** → [configure/settings.md](configure/settings.md)
- **Template, theme hook, CSS library, Bootstrap requirement, layout styles** → [theme/templates.md](theme/templates.md)

## Key facts
- Block plugin id: `diba_carousel` (admin_label "Diba carousel", category "Content"), class `Drupal\diba_carousel\Plugin\Block\DibaCarousel`.
- Config schema: `block.settings.diba_carousel` (`config/schema/diba_carousel.schema.yml`) — ~35 keys stored on each block instance.
- Theme hook: `block__diba_carousel` → `templates/block--diba-carousel.html.twig` (declared by `diba_carousel_theme()`).
- CSS library: `diba_carousel/diba-style` (`assets/css/diba-carousel.css`), attached from the template only when `carousel_style == 'diba'`.
- Query tag `random_order` (altered by `diba_carousel_query_random_order_alter()` → `orderRandom()`) implements the "Random" order direction.
- Optional integration: `custom_pub` — its custom publishing options appear as extra publishing-option filters for nodes.
- Ships no JS. Relies on the theme supplying Bootstrap 3/4/5 CSS+JS for the sliding behaviour (works with Bootstrap, Barrio, etc.).
- Update hook `diba_carousel_update_8001()` re-imports default config; `hook_help` renders `README.md` (optionally via `markdown` / `markdown_easy`).
