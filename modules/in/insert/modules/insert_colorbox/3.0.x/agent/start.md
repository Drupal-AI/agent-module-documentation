<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Insert Colorbox — agent index

Submodule of **Insert**. Adds `colorbox__<image-style>` insert styles so images inserted into a text
area open in a Colorbox lightbox, and injects an **Insert Colorbox** fieldset into the shared Insert
settings form. Its persistent state is one config object, `insert_colorbox.config`.

- **Config object keys (style, gallery), where set, drush** →
  [configure/insert-colorbox.md](configure/insert-colorbox.md)

Key facts:
- Config object `insert_colorbox.config` (shipped defaults `style: image`, `gallery: '0'`), edited on
  the parent Insert settings form (`/admin/config/content/insert`, permission `administer filters`)
  via `hook_insert_config_form` / `hook_insert_config_submit_form`.
- `style`: image style shown inside the Colorbox — an image-style name, `image` (original), or `0`
  (reuse the widget's "Link image to" setting).
- `gallery`: `post` | `page` | `field_post` | `field_page` | `0` (no gallery).
- Adds a `colorbox__<style>` insert style per image style (`hook_insert_styles`, image type) and
  renders them via `hook_insert_render` + the `insert_colorbox_image` theme hook.
- Depends on `colorbox` + `insert`. No own route/permissions. Extends Insert via the parent hooks
  (see the parent project's `agent/hooks/extend.md`).
