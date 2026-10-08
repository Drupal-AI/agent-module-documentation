<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Class — classes added and how they render

All logic lives in `default_class.module` (two preprocess hooks). No config,
no options — behavior is fixed. Install/enable and the classes appear.

## Install / enable

- `composer require drupal/default_class`
- `drush en default_class -y` (or `/admin/modules`)
- Nothing to configure afterward.

## `default_class_preprocess_block(&$variables)`

Runs for every rendered block. Appends to `$variables['attributes']['class']`:

- `block` — always.
- Normalized `$variables['configuration']['base_plugin_id']`'s plugin id via
  `Html::getClass($variables['plugin_id'])` — **skipped** when `base_plugin_id`
  is `block_content` (avoids a class per individual content block).
- `Html::getClass($variables['configuration']['provider'])` — the providing
  module's machine name (e.g. `system`, `views`, `user`).
- `block--<region>` — only when the block entity loads
  (`Block::load($variables['elements']['#id'])`); region from
  `$block->getRegion()`, normalized with `Html::getClass()`.
- `block--block-content--<bundle>` — only when `$variables['content']['#block_content']`
  is set; bundle from `->bundle()`, normalized with `Html::getClass()`.

Note the module `use`s `Drupal\block\Entity\Block`, so the region class relies
on the core Block module being present (it is, by default, for placed blocks).

## `default_class_preprocess_html(&$variables)`

Inspects the current route parameters (`\Drupal::routeMatch()`) and appends
page-level classes on canonical entity pages:

- Node (`$node instanceof NodeInterface`): `node-<nid>` and `node-<bundle>`
  (from `$node->getType()`).
- User (`user` route param): `user-<uid>` and `user-<accountName>`
  (from `$user->getAccountName()`).
- Taxonomy term (`taxonomy_term` route param): `term-<tid>`,
  `term-name-<label>` (label lowercased, spaces → `-`), and
  `term-vid-<vocabulary>` (from `$term->vid->target_id`).

## Rendering & escaping

Classes are pushed into `$variables['attributes']['class']`, which Drupal
converts to an `Attribute` object; attribute values are escaped on output by
core's attribute rendering. Machine-id-derived values additionally pass through
`Html::getClass()`. There is no custom raw/markup output in this module.

## Operating notes

- No UI, no settings form, no permissions — appearance is uniform site-wide.
- To use the classes, write CSS/JS in your theme targeting the selectors above
  (e.g. `.block--sidebar-first`, `.node-article`, `.term-vid-tags`).
- The user account-name and term-name classes reflect live entity labels, so
  they change if the account name or term name changes.
