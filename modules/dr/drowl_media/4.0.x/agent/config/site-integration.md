<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Breakpoints, the media_library view, libraries, hooks & install

Everything the base module wires into the site besides the slideshow plugins. No config form and
no config-object settings — the base module has only config *schema* (`media.source.slideshow`) and
one *optional* view.

## Install & enable

```bash
composer require drupal/drowl_media
drush en drowl_media -y
```

`drowl_media_install()` copies the module's `images/icons/*` (svg/png/jpg/gif) into the media icon
directory (`media.settings:icon_base_uri`), skipping files that already exist.
`drowl_media_requirements()` at runtime **errors on the status report** unless the external asset
library `npm-asset/drowl-admin-iconset` is present at `/libraries/drowl-admin-iconset/style.css`
(install it via asset-packagist / Composer). The `.install` also carries legacy `hook_update_N`
routines (8200–8206, 8300–8304) that migrated the old `media_entity`-based setup to core Media and
replace the `media_library` view — not relevant to fresh installs.

## Breakpoints (`drowl_media.breakpoints.yml`)

Group `drowl_media` with five breakpoints, each `1x`:

| id | media query |
|---|---|
| `drowl_media.small` | `max-width: 640px` |
| `drowl_media.medium` | `641–1024px` |
| `drowl_media.large` | `1025–1366px` |
| `drowl_media.xlarge` | `1367–1920px` |
| `drowl_media.xxlarge` | `min-width: 1921px` |

These back the responsive image styles the `drowl_media_types` submodule ships.

## The `media_library` view (`config/optional/views.view.media_library.yml`)

Optional config (installed only when its dependencies exist; `enforced.module: media_library`). It
replaces core's `media_library` view. Displays: `default`, `page` (`admin/content/media`),
`widget` (grid, `admin/content/media-widget`), `widget_table` (`admin/content/media-widget-table`).
Notable DROWL changes vs core: exposed **Media folder** and **Media Tags** taxonomy filters; a
**bundle** "type" field + **#ID** column; a bundle CSS class on each row
(`media-library-item--bundle-{{ bundle_1 }}`); grid pager default 120 items. Access is core's
`access media overview` (default/page) and `view media` (widget displays) — unchanged from core.

## Libraries (`drowl_media.libraries.yml`)

`global`, `bundle_documents`, `bundle_slideshow`, `bundle_video` (frontend CSS), `admin` (+ its
`admin_iconset` dependency on the external iconset), `admin_media_library` (+ `_claro` variant, JS),
`admin_views_bulk_operations` (JS). All CSS/JS are minified dist assets shipped in the module.

## Hooks (`drowl_media.module`)

- `hook_preprocess_media()` — attaches `drowl_media/global` to every media, plus a per-bundle CSS
  library (`bundle_documents` for document; `bundle_video` for video/remote_video; `bundle_slideshow`
  for slideshow).
- `hook_page_attachments()` — attaches `drowl_media/admin` on admin routes.
- `hook_library_info_alter()` — makes `views_bulk_operations/frontUi` depend on
  `drowl_media/admin_views_bulk_operations` (restyled VBO bar).
- `hook_views_pre_render()` / `hook_field_widget_single_element_form_alter()` /
  `hook_ENTITY_TYPE_view()` — attach the Media Library restyle library (Claro vs Gin variant chosen
  by `system.theme:admin`).
- `hook_form_alter()` — for `entity_embed_dialog*` forms, narrows the image-style options to the
  preferred `page_width_25/50_lg[_scale]` styles when present.
- `hook_field_widget_single_element_form_alter()` — makes media `field_copyright` accept a
  link **title with no URI** (custom `_drowl_media_copyright_link_validate()` sets `<nolink>` so the
  item is not treated as empty).
- `hook_field_widget_single_element_media_library_widget_form_alter()` — adds the "Create new
  Slideshow" button (see plugins/slideshow.md).
