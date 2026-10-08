<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# The derived block plugin

`Drupal\entity_browser_block\Plugin\Block\EntityBrowserBlock` (`#[Block(id: "entity_browser_block",
… deriver: EntityBrowserBlockDeriver::class)]`). It is **not** a plugin *type* — it is one
block plugin that is **derived**, so you never place `entity_browser_block` directly.

## The deriver

`Drupal\entity_browser_block\Plugin\Derivative\EntityBrowserBlockDeriver` loads every
`entity_browser` config entity and emits one derivative per browser:

- **Derivative id** = the Entity Browser machine name (`$browser->id()`).
- **Full plugin id** = `entity_browser_block:{browser_machine_name}` (e.g.
  `entity_browser_block:eval_browser`).
- **admin_label** = the browser's label; all appear under the **Entity Browser** category in
  the block picker.
- Each derivative adds a config dependency on its browser
  (`entity_browser.browser.{name}`).

Consequence: **no Entity Browsers ⇒ no derivatives ⇒ nothing to place.** Create a browser
first (`entity_browser.browser.*` config entity). New browsers appear after a block-plugin
cache clear (`drush cr`).

## Settings shape

`defaultConfiguration()` → `['entity_ids' => [], 'view_modes' => []]`. Schema
`block.settings.entity_browser_block:*` (config/schema):

| Key | Type | Meaning |
|---|---|---|
| `entity_ids` | sequence of strings | ordered selection, each `entity_type:entity_id` (e.g. `node:1`, `media:4`) |
| `view_modes` | map string→string | keyed by the same `entity_type:entity_id`, value is the view-mode machine name (e.g. `teaser`, `full`, `default`) |

`entity_ids` is an **ordered list**; `view_modes` is keyed by the id (not by list position).
Every id present in `entity_ids` should have a matching key in `view_modes`.

## Form and submit

- `blockForm()` embeds `#type => entity_browser` for the derivative's browser
  (`#entity_browser => $this->getDerivativeId()`), plus a drag-sortable `table` where each
  selected entity gets a **view mode** `select` and a **Remove** button.
- `blockValidate()` requires at least one selected entity.
- `blockSubmit()` sorts rows by `_weight` and writes `entity_ids` (ordered) and
  `view_modes` (id → view mode).

## Render / access / caching (`build()`)

- Loads each entity via `loadEntitiesByIds()` (splits `entity_type:id`) and renders it with
  `entityTypeManager->getViewBuilder($type)->view($entity, $view_modes[$id])`.
- Merges each entity's cache metadata and the `view` access result onto the render array;
  entities the user cannot `view` render empty.
- `RECURSIVE_RENDER_LIMIT = 2` guards against an entity embedding itself endlessly.

## Dependencies

`calculateDependencies()` adds, per selected entity, the entity's own config/content
dependency and its `core.entity_view_display.{type}.{bundle}{view_mode}` display, plus
`entity_browser.browser.{derivative_id}`.
