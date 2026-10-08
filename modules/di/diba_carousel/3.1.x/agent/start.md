<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diba Carousel Slider (diba_carousel) — agent index

A single **block plugin** (`diba_carousel`) that renders a Bootstrap carousel/slider straight
from a fieldable entity type's own fields — no slide content type, no view, no Entityqueue. You
place the block, then pick the entity type, filter/sort the content, and map fields to
image / title / description / link. Slide data and all styling options live in the block
instance's own configuration. In Layout Builder / paragraph layouts it can reuse the current
context entity automatically.

- Dependencies: core only — `block`, `user`, `node`.
- Core: `^10.3 || ^11 || ^12`. No composer requirements beyond `drupal/core`.
- **No settings route** (`configure` is null), no permissions of its own, no drush commands.
  Everything is done from the block-layout UI, gated by core's `administer blocks`.
- The block delegates to four services (options / query / slide / form builders) — see
  [api/services.md](api/services.md).

## Solutions
- **Understand / operate the carousel block (build pipeline, entity query, context, image strategies, filter tokens, caching)** → [blocks/diba_carousel.md](blocks/diba_carousel.md)
- **The four services and their interfaces (how the pipeline is wired, what to reuse)** → [api/services.md](api/services.md)
- **Every block-config key, its default and meaning; set config via PHP/drush** → [configure/settings.md](configure/settings.md)
- **Template, theme hook, CSS library, Bootstrap requirement, layout styles** → [theme/templates.md](theme/templates.md)

## Key facts
- Block plugin id: `diba_carousel` (admin_label "Diba carousel", category "Content"), class `Drupal\diba_carousel\Plugin\Block\DibaCarousel`, with a `ContextDefinition("entity")` (required = FALSE) for Layout Builder / paragraph context.
- Services (`diba_carousel.services.yml`): `diba_carousel.options_provider`, `diba_carousel.query_builder`, `diba_carousel.slide_builder`, `diba_carousel.form_builder`.
- Config schema: `block.settings.diba_carousel` (`config/schema/diba_carousel.schema.yml`) — ~37 keys stored on each block instance.
- Theme hook: `block__diba_carousel` → `templates/block--diba-carousel.html.twig` (declared by `diba_carousel_theme()`).
- CSS library: `diba_carousel/diba-style` (`assets/css/diba-carousel.css`), attached from the template only when `carousel_style == 'diba'`.
- Query tag `random_order` (altered by `diba_carousel_query_random_order_alter()` → `orderRandom()`) implements the "Random" order direction.
- Optional integrations: `custom_pub` (extra node publishing-option filters) and `responsive_image` (responsive image style option).
- Ships no JS. Relies on the theme supplying Bootstrap 3/4/5 CSS+JS for the sliding behaviour (works with Bootstrap, Barrio, etc.).
- Update hook `diba_carousel_update_8001()` re-imports default config; `hook_help` renders `README.md` (optionally via `markdown` / `markdown_easy`).
