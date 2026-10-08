<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Loaders & renderers

Two services: `bamboo_twig_loader.twig.loader` (return objects) and
`bamboo_twig_loader.twig.render` (return render arrays; all `render_*` are `is_safe: html`).
When the `id` argument is omitted, the entity is taken from the **current route** parameter.

## Loaders (objects)

- `bamboo_load_entity(entity_type, id = null, langcode = null)` — translation-aware; null if missing.
- `bamboo_load_entity_revision(entity_type, revision_id = null, langcode = null)`.
- `bamboo_load_field(field_name, entity_type, id = null, langcode = null)` — the FieldItemList, or null if empty/missing.
- `bamboo_load_currentuser()` — the User entity, or null when anonymous.
- `bamboo_load_image(path)` — an ImageInterface for a path/URI.

## Renderers (render arrays)

- `bamboo_render_block(block_id, params = {}, wrapper = false)` — block plugin by id; applies runtime
  contexts; `wrapper=true` wraps in the `block` theme.
- `bamboo_render_form(module, form, params = null)` — builds `Drupal\<module>\Form\<form>`.
- `bamboo_render_entity(entity_type, id = null, view_mode = '', langcode = null)`.
- `bamboo_render_entity_revision(entity_type, revision_id = null, view_mode = '', langcode = null)`.
- `bamboo_render_region(region, theme = null)` — all blocks in a region (default theme if omitted).
- `bamboo_render_field(field_name, entity_type, id = null, langcode = null, formatter = null)` — label hidden; default formatter if none given.
- `bamboo_render_image(file_id, style, alt = null)` — via the `image_style` theme.
- `bamboo_render_image_style(path, style, preprocess = false)` — the derivative URL (preprocess pre-generates it).
- `bamboo_render_menu(menu_name, level = 1, depth = 0)` — depth 0 = unlimited; access-checked, sorted.
- `bamboo_render_views(name, display, ...args)` — alias of core `views_embed_view`.

## Examples

```twig
{{ bamboo_render_entity('node', 5, 'teaser') }}
{{ bamboo_render_block('system_branding_block') }}
{{ bamboo_render_region('sidebar_first') }}
{{ bamboo_render_menu('main', 1, 2) }}
{{ bamboo_render_field('field_image', 'node', 5, null, 'image') }}
{% set author = bamboo_load_currentuser() %}
```
