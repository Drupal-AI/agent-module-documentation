<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcut nesting mechanism (shortcut_menu)

How the module turns core's flat shortcut set into a nested menu. Whole feature is four
integration points on the existing core `shortcut` entity — no routes, config, permissions, or
schema of its own. Cite: `shortcut_menu.module`, `src/Form/ShortcutMenuSetCustomize.php`,
`src/ShortcutMenuLazyBuilder.php`, `shortcut_menu.services.yml`, `shortcut_menu.install`.

## 1. Two base fields on `shortcut`

`shortcut_menu_entity_base_field_info()` (`shortcut_menu.module`) adds, only when
`$entity_type->id() == 'shortcut'`:
- **`parent`** — `string`, `max_length` 50, default `NULL`. Stores the parent shortcut's **UUID**
  (not its integer id), so an exported/imported set stays valid across environments.
- **`depth`** — `integer`, default `0`. Nesting level; `0` = top level.

Because these are base fields from `hook_entity_base_field_info()`, installing the module triggers
an entity-definition update that adds the `parent`/`depth` columns to `shortcut_field_data`, and
**uninstalling removes those columns and their data** (verified by
`tests/src/Kernel/ShortcutMenuTest::testShortcutTable`). Shortcuts survive uninstall; nesting is
lost and the set reverts to flat.

## 2. Customize form swap (edit UI)

`shortcut_menu_entity_type_build()` calls
`$entity_types['shortcut_set']->setFormClass('customize', ShortcutMenuSetCustomize::class)`. The
route is unchanged core: **`entity.shortcut_set.customize_form`**
(`/admin/config/user-interface/shortcut/manage/{shortcut_set}/customize`), still gated by core's
`_entity_access: shortcut_set.update` — the module adds no route or permission.

`ShortcutMenuSetCustomize extends Drupal\shortcut\Form\SetCustomize`:
- `form()` calls `parent::form()`, then attaches tabledrag settings from `getTableDragSettings()`
  (three relationships: `parent` match on `shortcut-parent`, `depth` group on `shortcut-depth`,
  `order`/sibling on `shortcut-weight`) so rows can be dragged **and indented**. For each shortcut
  it renders an `indentation` theme prefix and adds three hidden fields to the first column:
  `shortcut_id`, `parent` (the parent's row id, `0` at root), and `depth`.
- `save()` reads `['shortcuts','links']`, re-weights via `sortLinkWeights()`/`getRootWeight()`
  (children inherit their root parent's weight, then a tiny increment keeps siblings ordered), and
  for each shortcut writes `parent` (converted id→UUID by `getShortcutUuidFromId()`), `weight`, and
  `depth`, then `save()`s the entity. `$first_column['#title'] = $shortcut->getTitle()` is a Form
  API `#title` (theme-escaped), not raw markup.

Helpers `getShortcutIdFromUuid()` / `getShortcutUuidFromId()` map between the stored UUID and the
row id by scanning `$this->entity->getShortcuts()`.

## 3. Rendered toolbar tree (lazy builder decorator)

`shortcut_menu.services.yml` registers `shortcut_menu.lazy_builder` with
`decorates: shortcut.lazy_builders` (priority 1), constructed with the inner service and
`@entity_type.manager`.

`ShortcutMenuLazyBuilder extends ShortcutLazyBuilders`. `lazyLinks()`:
1. Calls the inner `lazyLinks()` to get the current user's flat `$links['shortcuts']['#links']`
   (returns early unchanged if that key is absent).
2. Loads those shortcut entities by `array_keys()` of that array only, and finds the max `depth`.
3. Walks depths top-down; for each shortcut whose `depth` matches and whose resolved `parent`
   (UUID→id via `getParentIdFromUuid()` → `loadByProperties(['uuid' => …])`) is present, moves it
   under `['#links'][$parent]['below'][…]`, re-sorting siblings by weight
   (`SortArray::sortByWeightElement`).
4. Retypes the render array to `#theme => 'menu'`, `#menu_name => 'shortcut_menu'`, `#items => …`,
   and attaches library `shortcut_menu/toolbar`.

It never widens the link set — it only re-nests entries core already returned for the current user.

Styling: `shortcut_menu.libraries.yml` defines the `toolbar` library
(`css/shortcut_menu.shortcut.css`).

## 4. Update path

`shortcut_menu_update_9000()` (`shortcut_menu.install`) migrates legacy integer-id `parent` values
to UUIDs: it snapshots parents, nulls the column, uninstalls and reinstalls the `parent` field
storage definition, then rewrites each row's parent to the referenced entity's UUID. Wrapped in a
DB transaction; uses parameterised `select()/update()->condition()`.

## Operate it

1. `drush en shortcut_menu -y` (core `shortcut` is a dependency).
2. Edit a set at `/admin/config/user-interface/shortcut/manage/{set}/customize` — drag rows right
   to indent them under a parent, save.
3. The toolbar/shortcut block renders the nested tree automatically.

Governed entirely by core shortcut permissions: `administer shortcuts`,
`customize shortcut links`, `access shortcuts`.
