<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MenuManipulator — method reference

Instantiate per menu, then call methods:

```php
use Drupal\codit_menu_tools\MenuManipulator;

$m = new MenuManipulator('main'); // menu machine name; throws if the menu is empty/missing
```

Construction (`MenuManipulatorBase::__construct`) grabs `menu_link_content` storage,
`plugin.manager.menu.link`, `\Drupal::menuTree()`, and `\Drupal::logger('codit_menu_tools')` via the
static locator, then eagerly loads the tree with `getMenuTree($menu_name)`. An **empty or missing
menu name throws `\Exception`**; a name that loads an **empty tree also throws** (`"found no menu by
the name ..."`). All manipulation operates on `menu_link_content` links only (menu links defined in
YAML/`*.links.menu.yml` are in the tree for lookup but `updateDefinition`/`create` act on content
links).

## Write methods (`MenuManipulator`)

### `addMenuItem(string $item_title, string $item_destination, string $item_description = '', bool $enabled = TRUE, string $parent_title = '', string $sibling_title = '', bool $below = TRUE): int`
Creates a new `MenuLinkContent` entity. Requires non-empty title and destination
(`preCheckRequiredItemValues()` throws `\Exception` otherwise). Calls `menuSeparate()` first, locates
the parent by title and sibling by title (scoped to that parent), computes the new weight as
`sibling_weight ± 1` (`+1` if `$below`), sets `parent` to the sibling's parent id (fallback: the
parent's own plugin id), saves, then `menuSeparate()` again. Destination is a Drupal URI string, e.g.
`"entity:node/123"`, `"internal:/some/path"`, `"route:<front>"`. Returns the `save()` result
(`SAVED_NEW`). If parent/sibling titles are not found, weight falls back to 0 and the item still gets
created (at/near the top after re-spacing).

### `changeMenuItemTitle(string $original_title, string $new_title, string $parent_title = ''): bool`
Renames an item. Thin wrapper: `changeMenuItem($original_title, $new_title, $parent_title, $parent_title)`
(same parent in and out → rename only). `$parent_title` only narrows the lookup. Returns TRUE if
renamed, FALSE if the item wasn't found.

### `changeMenuItemParent(string $menu_item_title, string $original_parent_title, string $new_parent_title, string $new_sibling_title = '', bool $below = TRUE): bool`
Reparents an item (title unchanged). Wrapper over `changeMenuItem($title, $title, $orig_parent,
$new_parent, $new_sibling, $below)`. Returns FALSE (and logs a notice) if the **new parent** title
isn't found — the move is aborted.

### `changeMenuItemSibling(string $menu_item_title, string $parent_title, string $new_sibling_title = '', bool $below = TRUE): bool`
Re-orders within the same parent by placing next to a named sibling. Wrapper over `changeMenuItem`
with `original_parent === new_parent`. Returns FALSE if the sibling isn't found.

### `changeMenuItem(string $original_title, string $new_title, string $original_parent_title, string $new_parent_title, string $new_sibling_title = '', bool $below = TRUE): bool`
The general rename+reparent+re-sibling operation the wrappers above delegate to. Loads the item by
title+original-parent. Applies, as needed: title change (if titles differ), parent change (if parent
titles differ; **aborts with FALSE** if the new parent can't be loaded), sibling weight
(`sibling_weight ± 1`; **aborts with FALSE** if a `$new_sibling_title` is given but not found). If any
of the three changed, it calls `menuSeparate()`, `menuManager->updateDefinition()`,
`clearMenuTreeCache()`, and logs an info message. Returns `renamed || reparented || resiblinged`.
Note: it mutates the **plugin definition** array and calls `updateDefinition()` (not
`$entity->save()`).

### `moveMenuItem(string $item_title, string $parent_title = '', string $sibling_title = '', bool $below = TRUE, bool $last_run = TRUE): bool`
Moves an item to a new weight under the same parent. With no `$sibling_title`, sends it to the
menu top (`-2`) or bottom (`highest_weight + 2`) depending on `$below`; with a sibling, uses
`sibling_weight ± 1`. Missing sibling or missing item → logged notice, returns FALSE. Only re-spaces
(`menuSeparate()`) on exit when `$last_run` is TRUE — set FALSE for all but the final call when moving
many items, to avoid stacked re-spacing. Duplicate of `changeMenuItemSibling` per the README; a
`@todo` notes it should be refactored to use `changeMenuItem`.

### `matchPattern(array $pattern, string $parent = ''): void`
Re-arranges items to match the order in `$pattern` by repeatedly calling `moveMenuItem`. A flat array
`['a','b','c']` orders siblings; a nested array keyed by parent title
(`['parent1' => ['a','b'], 'parent2' => ['c','d']]`) recurses into each subtree. **Cannot change an
item's parent** — order only. The first item in a list stays put and is used as the anchor for the
rest. Passes `last_run = TRUE` only on the final iteration.

### `menuSeparate(): int`
Re-weights every item in the menu to spaced multiples of 2 (`2, 4, 6, …`) while preserving the
current order and hierarchy (via `separateTreeBranch()` + `mimicDrupalMenuSort()` which mimics
Drupal's weight-then-id sort), then rebuilds the menu link manager and clears the tree cache. Returns
the highest weight used (useful as an insertion ceiling). Called internally by the write methods.

## Read / helper methods (`MenuManipulatorBase`)

- `getMenuTree(string $menu_name = ''): array` — returns the cached `MenuLinkTreeElement[]`, loading
  it if needed; throws if no name is known or the tree is empty.
- `loadMenuItemByNameAndParentName(string $title = '', string $parent_title = ''): MenuLinkContent|null`
  — resolves the parent title to an id, then defers to the id variant. Returns the plugin
  (`\Drupal\menu_link_content\Plugin\Menu\MenuLinkContent`) or NULL.
- `loadMenuItemByNameAndParentId(string $title = '', $parent_id = ''): MenuLinkContent|null` — loads
  via `MenuTreeParameters` conditions on `title` (and optionally `parent`). Not found → logs a notice,
  returns NULL. Multiple matches → logs a notice and returns the **last** (`end($tree)`).
- `findMenuItemDetailsByName(string $title = '', $parent_id = ''): array` — returns
  `['mid' => entity id, 'id' => plugin id, 'weight' => int (0 if none), 'parent_id' => plugin id]`,
  or `[]` if not found.
- `getAllMenuNames(string|null $machine_name_partial = NULL): array` — **static**. Returns
  `['machine_name' => 'Label']` for all `Menu` config entities, optionally filtered to names
  containing the partial (`str_contains`), sorted by label. `MenuManipulator::getAllMenuNames('admin')`.

## Behavioural notes for callers

- Identity is by **title**, so duplicate titles are ambiguous — the code deliberately acts on the last
  match and logs. Scope with a parent title where possible.
- Almost everything is idempotent-ish through `menuSeparate()`, but calling many single-item moves each
  triggers a full re-space + `menuManager->rebuild()`; batch with `moveMenuItem(..., $last_run = FALSE)`
  or `matchPattern()` for performance.
- Because it runs in update/script context, expect it to be invoked with the site's full privileges;
  it performs no access checks of its own (see the developer-only nature above).
