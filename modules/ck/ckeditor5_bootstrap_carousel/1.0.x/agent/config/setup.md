<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, enable & configure

## Install

- `composer require drupal/ckeditor5_bootstrap_carousel` then `drush en ckeditor5_bootstrap_carousel`.
- Requires core module `ckeditor5` (auto-enabled dependency). Core `^10.6 || ^11.3`.
- No install hooks, no config to import, no permissions to grant (the module ships none).

## Enable on a text format (per format, both steps required)

At `/admin/config/content/formats/manage/<format>` (Full HTML or a custom format using CKEditor 5):

1. Drag the **Carousel** button from "Available buttons" onto the active toolbar. This turns on the
   `bootstrapCarousel` CKEditor 5 plugin.
2. In the format's filter list, check **Carousel enabler** (`filter_bootstrap_carousel`). The Carousel
   button will not appear until this filter is enabled — the plugin's `conditions.filter` gates it.
3. If "Limit allowed HTML tags and correct faulty HTML" (`filter_html`) is on, the plugin's declared
   `elements` are added to the allowed tags automatically; no manual allowed-HTML editing needed.

## Front-end requirement

The module loads **no Bootstrap library**. For carousels to display and animate, the site's front-end
**theme must already include Bootstrap 5's CSS and JavaScript**. Nothing is loaded from a CDN by this
module. The admin/editing CSS (`css/bootstrap-carousel.admin.css`, `.editor.css`) is shipped and used
only inside the editor.

## Configuration surface

- No settings route (`configure: null`), no config-install/schema objects.
- All configuration lives in the text-format's editor + filter settings (`editor.editor.<format>` and
  `filter.format.<format>`).
- Developer extension point: append toolbar item plugin names to
  `editor.config.bootstrapCarousel.toolbarItems` — see
  [`../plugins/bootstrap-carousel.md`](../plugins/bootstrap-carousel.md).

## Styling

Override Bootstrap 5 CSS variables in your theme to restyle carousels without changing markup; the
generated HTML is standard Bootstrap 5 carousel structure.
