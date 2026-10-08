<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Loaders is the richest Bamboo Twig submodule: Twig functions to load and render Drupal entities, revisions, fields, blocks, regions, forms, menus, views and images from a template.

---

This submodule provides two services: `bamboo_twig_loader.twig.loader` with `bamboo_load_*` functions that return objects (entities, fields, revisions, current user, image objects), and `bamboo_twig_loader.twig.render` with `bamboo_render_*` functions that return render arrays (blocks, forms, entities, regions, fields, images, image styles, menus, views). All are translation-aware where relevant, and when an entity `id` is omitted the entity is taken from the current route. The `render_*` functions are marked `is_safe: html`. It lets themers compose pages from arbitrary Drupal building blocks directly in Twig, without custom preprocess code.

---

- Render an entity by type and id in a chosen view mode (`bamboo_render_entity('node', 5, 'teaser')`).
- Render the current route's node without knowing its id.
- Render a specific entity revision in a template.
- Render a single field with the default or a named formatter (`bamboo_render_field`).
- Embed a configured block by plugin id (`bamboo_render_block('system_branding_block')`).
- Wrap a rendered block in the standard block theme via the `wrapper` flag.
- Render all blocks assigned to a theme region (`bamboo_render_region('sidebar_first')`).
- Embed an arbitrary Drupal form by module and class (`bamboo_render_form`).
- Render a menu tree with level and depth control (`bamboo_render_menu('main', 1, 2)`).
- Embed a View display by name (`bamboo_render_views('frontpage', 'page_1')`).
- Output an image-style derivative URL (`bamboo_render_image_style`), optionally pre-generating it.
- Render an image via a style using a file id (`bamboo_render_image`).
- Load an entity object for inspection in a template (`bamboo_load_entity`).
- Load a single field's item list (`bamboo_load_field`).
- Load a specific entity revision object.
- Get the current user entity (`bamboo_load_currentuser`), null when anonymous.
- Load an ImageInterface object from a path or URI.
- Build a custom "related content" block by loading and rendering entities in Twig.
- Compose a landing page from regions, blocks and views without a layout module.
- Render a referenced entity (e.g. a media item) inline in a field template.
