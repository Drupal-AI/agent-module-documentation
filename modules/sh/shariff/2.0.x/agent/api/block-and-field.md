# Placement & rendering — block, node field, theming

Two ways to output the buttons; both theme through `block_shariff` and attach a
`shariff/shariff-<variant>` library.

## Block plugin `shariff_block`

`Drupal\shariff\Plugin\Block\ShariffBlock` (`@Block id "shariff_block"`, admin label
"Shariff share buttons"). Place it via *Block layout* (`/admin/structure/block`) or a block
config entity.

- Block form has **Use Shariff default settings** (`shariff_default_settings`, default TRUE).
  When ticked the block uses `shariff.settings`. Untick to override any of the same
  `shariff_*` keys per block instance (the extra fields appear via `#states`).
- Cache: contexts include `url`; tags include `config:shariff.settings`.

Block config entity settings live under the block's `settings.shariff_*` keys, e.g.:

```yaml
settings:
  id: shariff_block
  shariff_default_settings: false
  shariff_services: { whatsapp: whatsapp, mail: mail }
  shariff_theme: white
```

## Node display field `shariff_field`

`shariff_entity_extra_field_info()` adds an extra display component **`shariff_field`**
("Shariff sharing buttons") to **every node type** (hidden by default). Enable it on a bundle's
*Manage display* (`/admin/structure/types/manage/<type>/display`) — i.e. give the
`entity_view_display` a `shariff_field` component. `shariff_node_view()` then renders the
buttons for that node, sharing its canonical URL and title (Metatag title token if the Metatag
module is on).

```php
// Enable the buttons on Article's default view display.
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node', 'article', 'default');
$vd->setComponent('shariff_field', ['weight' => 100, 'region' => 'content'])->save();
```

Read back:

```bash
drush cget core.entity_view_display.node.article.default content.shariff_field
```

## Theming & data attributes

- Theme hooks (`shariff_theme()`): `block_shariff` → `templates/shariff.html.twig`;
  `help_shariff` → `shariff--help.html.twig`.
- `shariff_preprocess_block_shariff()` turns each setting into a `data-<key>` attribute
  (underscores → dashes) that the Shariff JS reads, and attaches
  `shariff/shariff-<css_variant>` (plus `shariff/shariff-native` when `shariff_hidden`).
- `shariff_library_info_alter()` resolves the real library path under `/libraries/shariff`
  (supports `/build` and `/dist` subfolders).

## External library requirement

`shariff.install`'s `hook_requirements` errors until the heise online Shariff library
(≥ 1.4.6) is under `/libraries/shariff/` (so `…/shariff.min.js` resolves). The buttons only
render fully once that asset is present; all *configuration* above works without it.

## No custom permissions / Drush / plugin types

Settings access uses core `administer site configuration`. The module defines no permissions
file, no Drush commands, and no plugin types to implement.
