<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Releases (webreleases) — agent index

Config-bundle / recipe module (Webship `web*` suite). Version **12.0.1**, core `^11.4 || ^12`.
Provisions a **Product** and a **Release** node type (release → product via `field_product`), two
Views, Pathauto patterns, a menu link, and a path processor for pretty release URLs. No settings
form, no permissions, no config schema of its own (all config ships in `recipes/default/config`).

## Dependencies (composer.json `require`, minus php/core)
- `drupal/webdev ^12.0`, `drupal/webassets ^12.0` (Image media type), `drupal/webpage ^12.0`
  (body field storage + editorial workflow), `drupal/manage_display ~3.0`,
  `drupal/display_builder ^1.0@beta`. The recipe also enables core `path`, `pathauto`, `text`,
  `link`, `image`, `node`, `user`, `views`, `menu_ui`, `menu_link_content`, `content_moderation`,
  `media`, `media_library`, `smart_trim` and the `display_builder_*` set.

## What it provides
- **Node types**: `product`, `release` (both new-revision, preview enabled, on the `main` menu).
- **Fields**: `field_image` (product, Media→image), `field_product` (release→product node ref,
  required, cardinality 1), `field_release_image` (release, Media→image), `field_release_link`
  (release, link field, generic internal+external), plus `body` from the Webpage recipe.
- **View modes/displays**: teaser/full/archive/product_release, built for Display Builder.
- **Views**: `products` and `releases` — see [views/views.md](views/views.md).
- **URLs**: Pathauto patterns + `WebReleasesProductPathProcessor` — see
  [routing/urls.md](routing/urls.md).
- **Hook**: `WebReleasesHooks::nodeViewAlter` (`#[Hook('node_view_alter')]`) re-adds `node--*` CSS
  classes to Display-Builder-rendered product/release output.
- **Service**: `webreleases.product_path_processor` (inbound priority 100, outbound priority 200).
- **Install**: `webreleases_install()` applies `recipes/default` when enabled standalone (skipped
  during config sync / when the recipe installs the module).

## Solution docs
- [content-model/content-types.md](content-model/content-types.md) — product + release types, fields, relationship, view modes/displays.
- [views/views.md](views/views.md) — the `products` and `releases` Views and their page/block displays.
- [routing/urls.md](routing/urls.md) — Pathauto patterns, the product path processor, menu link.
