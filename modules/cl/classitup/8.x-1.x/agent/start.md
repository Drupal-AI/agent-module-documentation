<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Class It Up — agent reference

Version **8.x-1.2** · branch `8.x-1.x` · core `^8 || ^9 || ^10 || ^11` · package Theme · license GPL-2.0-or-later.

Adds CSS classes to rendered markup based on metadata Drupal already knows —
region, plugin id, block/content-type bundle, node bundle, and route name. It
gives themers stable, machine-safe styling hooks so they don't have to write
preprocess functions or maintain templates that differ only by class. There is
**nothing to configure**: enable it and the classes appear automatically.

## Everything the module is
The entire module is one file, `classitup.module` (98 lines). There is NO
`src/`, no routes, no services, no permissions, no config, no schema, no
libraries, no templates, no install file, no submodules, and no dependencies. It
does not register a settings form or a `configure` route. Two hook
implementations do all the work:

### `classitup_preprocess_block(&$variables)`
Appends to a block's `attributes.class`:
- `block` (always).
- `Html::getClass($variables['plugin_id'])` — the full plugin id — **unless** the
  block is content (`configuration.base_plugin_id === 'block_content'`).
- `Html::getClass($variables['configuration']['provider'])` — the module/provider
  that defines the block.
- `block--<region>` — via `Block::load($variables['elements']['#id'])` then
  `Html::getClass($block->getRegion())`; null-guarded so contrib blocks without an
  id don't fatal.
- `block--block-content--<bundle>` — when `content['#block_content']` is set, using
  the custom block's `bundle()`.

### `classitup_preprocess_html(&$variables)`
Appends to the page/body `attributes.class`:
- On a node canonical/preview page (route param `node` or `node_preview` that is a
  `NodeInterface`): `page--content-item` and
  `page--content-item--<node-bundle>`.
- Else on a webform page (raw route param `webform`): cumulative classes built
  from the route name with the leading `entity.` dropped — e.g.
  `entity.webform.canonical` yields `page--webform` then `page--webform--canonical`.
- Else on a view page (route name whose first `.`-segment is `view`): the same
  cumulative pattern from the route name — e.g. `view.frontpage.page_1` yields
  `page--view`, `page--view--frontpage`, `page--view--frontpage--page_1`.

## Class value safety
Content-derived values (plugin id, provider, region, bundle) all pass through
`Drupal\Component\Utility\Html::getClass()`, producing lower-cased, machine-safe
tokens. Route-name-derived values are developer-defined identifiers, not user
input. All values are pushed into the Attribute array and escaped by Drupal's
render pipeline — the module never prints markup itself.

## Usage
```bash
composer require drupal/classitup
drush en classitup -y
```
Then target the emitted classes in your theme CSS (inspect a rendered page to see
them). Intended to be declared as a dependency by themes that want these hooks.
For adding custom classes to *fields*, the maintainers point to the separate
Field Formatter Class module instead.

## Related
`twigsuggest` (Template Suggester), `body_node_id_class`, Field Formatter Class.

See also the human-oriented guide in `../human-docs/`.
