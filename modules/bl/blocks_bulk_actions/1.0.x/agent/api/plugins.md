<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks Bulk Actions — form integration, batch flow & the plugin type

## Install / enable

`drush en blocks_bulk_actions -y` (or `ddev drush …`). No dependencies beyond Drupal core, no
configuration, no permissions of its own. After enabling, the actions bar appears automatically on
**Structure → Block layout** (`/admin/structure/block`).

## Where it hooks in

Everything lives in `blocks_bulk_actions.module`. `hook_form_alter()` returns early unless
`$form_id === 'block_admin_display_form'` — the **core** Block layout form (route
`block.admin_display`, `_permission: 'administer blocks'`). This module registers **no** route or
form; it only augments the core one, so the core page's access control governs who can use it.

What the alter adds:

- A `bulk_actions_container` (`#type container`, id `blocks-bulk-actions-container`) prepended to
  the form via `array_merge($bulk_elements, $form)`, containing:
  - `bulk_actions` — a `select` whose `#options` are built from the plugin manager (see below).
  - `select_all` — a checkbox (`#return_value 'all'`, id `blocks-bulk-actions-select-all`).
  - `actions.apply_action` — a submit button "Apply to selected items" with custom
    `#submit => ['blocks_bulk_actions_apply']`.
- A `selector` checkbox (`#return_value => $key`, class `block-selector`) on every `$form['blocks']`
  row that is an array containing a `region-theme` key, plus a new `Selector` column header.
- `$form['#attached']['library'][] = 'blocks_bulk_actions/scripts'`.

The option list is filtered by access: for each definition, if the class has an `access` method and
`$action->access(\Drupal::currentUser())` is TRUE, its `description` is added to the dropdown.

## Submit → batch flow

`blocks_bulk_actions_apply($form, FormStateInterface $form_state)`:

1. Reads `bulk_actions` (the chosen action id) and returns early if empty.
2. Builds `$selected_blocks`: if `select_all === 'all'`, all keys of `values['blocks']`; otherwise
   the keys whose row `selector` is truthy (`array_filter`).
3. If any are selected, loads the definition, and **only if** the class has an `execute` method and
   `$selected_action->access(\Drupal::currentUser())` is TRUE, sets a batch:
   - operation `blocks_bulk_actions_apply_action([$selected_blocks, $selected_action])` →
     `$selected_action->executeMultiple($selected_blocks)`, storing
     `actionFinishedMessage()` in `$context['results']['message']`.
   - `finished` → `blocks_bulk_actions_apply_action_finished()` prints that message (or
     "Finished with an error." on failure) via the messenger.

Because it is a standard Drupal FormAPI submit on a core form, CSRF is handled by the form token;
there is no separate GET action route.

## The plugin type

- **Service / manager:** `plugin.manager.blocks_bulk_actions` →
  `Drupal\blocks_bulk_actions\BlocksBulkActionsPluginManager` (final, `parent: default_plugin_manager`).
  Constructed for subdir `Plugin/BlocksBulkActions`, interface `BlocksBulkActionsInterface`,
  annotation `Annotation\BlocksBulkActions`; alter hook **`blocks_bulk_actions_info`**; cache key
  `blocks_bulk_actions_plugins`.
- **Annotation** `@BlocksBulkActions`: `id` (string, readonly), `description`
  (`@Translation`, shown in the dropdown), `bids` (array of block ids the action concerns; empty
  or omitted = all blocks).
- **Interface** `BlocksBulkActionsInterface`: `bids(): array`, `execute(string $id)`,
  `executeMultiple(array $blocks)`, `description()`, `actionFinishedMessage()`,
  `access(AccountProxyInterface $account)`.
- **Base** `BlocksBulkActionsPluginBase` (abstract, `StringTranslationTrait`): `executeMultiple()`
  loops `execute()` over each id; `description()`/`bids()` read the plugin definition;
  `actionFinishedMessage()` returns *'The action "@description" execution has been finished.'*;
  `access()` **defaults to `return TRUE`** — override it to restrict.

## Shipped actions (`src/Plugin/BlocksBulkActions/`)

| Class | id | `execute($id)` | `access()` |
|-------|----|----------------|-----------|
| `BlocksBulkActionsEnable` | `blocks_bulk_action_enable` | `Block::load($id)->setStatus(TRUE)->save()` | `hasPermission('administer blocks')` |
| `BlocksBulkActionsDisable` | `blocks_bulk_action_disable` | `Block::load($id)->setStatus(FALSE)->save()` | `hasPermission('administer blocks')` |
| `BlocksBulkActionsDelete` | `blocks_bulk_action_delete` | `Block::load($id)->delete()` | `hasPermission('administer blocks')` |

All three operate on core `block` config entities (`Drupal\block\Entity\Block`) and each is
`final`. Every shipped action re-checks `administer blocks` — both when building the dropdown and
before running the batch.

## Adding a custom action

Create `src/Plugin/BlocksBulkActions/MyAction.php` extending `BlocksBulkActionsPluginBase`:

```php
/**
 * @BlocksBulkActions(
 *   id = "my_bulk_action",
 *   description = @Translation("My custom action")
 * )
 */
final class MyAction extends BlocksBulkActionsPluginBase {
  public function execute(string $id) {
    if ($block = \Drupal\block\Entity\Block::load($id)) {
      // …operate on $block…
    }
  }
  public function access(\Drupal\Core\Session\AccountProxyInterface $account) {
    return $account->hasPermission('administer blocks');
  }
}
```

Only `execute()` is required (the base supplies the rest); **always override `access()`** to a real
permission check rather than relying on the base `return TRUE`, since it also drives whether the
action shows in the dropdown. Other modules can filter/modify discovered actions via
`hook_blocks_bulk_actions_info(&$definitions)`.

## Front-end (`blocks_bulk_actions/scripts`)

`js/blocks-bulk-actions.js` (`Drupal.behaviors.ux_guide`): the `#blocks-bulk-actions-select-all`
checkbox checks/unchecks every `.block-selector`; on window scroll past 100px the actions container
gets the `bba-sticky` class. `css/blocks-bulk-actions.css` styles/positions that sticky bar.
