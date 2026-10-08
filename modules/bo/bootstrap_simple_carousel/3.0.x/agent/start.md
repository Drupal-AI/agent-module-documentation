# Bootstrap Simple Carousel — agent index

One Bootstrap 5 carousel block fed by admin-managed image items. Depends on core `image` + `block`.
Provides one permission and a config schema; no Drush, no new plugin types.

- **Global settings, the carousel-item entity + management forms, the block, the permission, CDN assets, theming** →
  [configure/carousel.md](configure/carousel.md)

Key facts:
- Global config object: `bootstrap_simple_carousel.settings` (keys: `interval`, `wrap`, `pause`, `indicators`,
  `controls`, `assets`, `image_type`, `image_style`). Settings form: route `bootstrap_simple_carousel.admin_settings`
  at `/admin/config/media/bootstrap_simple_carousel` (perm `administer site configuration`).
- Content entity `bootstrap_simple_carousel` (base table, no bundles). Item forms at
  `/admin/structure/bootstrap_simple_carousel` (list/add/edit/delete), perm `access bootstrap simple carousel`.
- Block plugin id `bootstrap_simple_carousel_block`; shows active items (weight desc); visible with `access content`.
- Template `bootstrap--simple--carousel--block.html.twig`, theme hook `bootstrap_simple_carousel_block`.
- Bootstrap 5.3.3 loads from jsDelivr CDN only when the `assets` setting is enabled.
