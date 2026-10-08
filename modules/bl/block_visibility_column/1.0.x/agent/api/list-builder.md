<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visibility column list-builder

## Wiring
`block_visibility_column.module` implements `hook_entity_type_alter(&$entity_types)` and calls
`$entity_types['block']->setListBuilderClass(BlockVisibilityColumnListBuilder::class)`. That is the
module's entire integration surface — enabling the module swaps the list builder for the `block`
config entity; disabling it restores core's `Drupal\block\BlockListBuilder`. No route, permission,
service, config, or install hook is added. Clear caches after enable/disable so the entity-type
definition rebuilds.

## `BlockVisibilityColumnListBuilder`
File: `src/Controller/BlockVisibilityColumnListBuilder.php`. Extends
`Drupal\block\BlockListBuilder`.

### `buildBlocksForm()`
1. Loads block entities via `$this->load()`.
2. Calls `parent::buildBlocksForm()` to get core's per-region block table.
3. `array_splice($form['#header'], 4, 0, [$this->t('Visibility')])` inserts a "Visibility" header at
   index 4 (after core's Block / Category / Weight columns, before Operations).
4. Iterates the form rows; for each row that has an `operations` element it pops operations, inserts
   `$element['visibility'] = ['#markup' => implode('<br>', $this->getVisibility($entities[$key]))]`,
   then re-appends operations so the column ordering matches the header.

The cell is a `#markup` render element — Drupal runs it through `Xss::filterAdmin()` at render time.

### `getVisibility(Block $block): array` (private)
Reads `$block->getVisibility()` (the block's stored visibility-condition plugin configs) and formats
each condition into a human string `"<plugin_id> = <values>"`, or `"<plugin_id> <> <values>"` when the
condition's `negate` flag is set. A lookup table maps supported condition plugin IDs to the config key
holding their values:

| condition plugin id | value key(s) |
|---|---|
| `user_role` | `roles` |
| `language` | `langcodes` |
| `request_path` | `pages` |
| `entity_bundle:taxonomy_term` | `bundles` |
| `entity_bundle:node` | `bundles` |
| `token_matcher` (contrib **Token Conditions**) | `token_match`, `check_empty`, `value_match`, `use_regex` |

- Any condition plugin **not** in the table renders as `"<id> is not supported"` — so custom/other
  condition plugins simply show as unsupported rather than erroring.
- Array values (roles, langcodes, bundles) are joined with `, `.
- Scalar values (e.g. `request_path.pages`) have `<`/`>` replaced with `&lt;`/`&gt;` and CRLF replaced
  with `, ` before display.
- `token_matcher` is rendered as `key=value` pairs; booleans print as `TRUE`/`FALSE`.

## Extending
To surface an additional condition plugin, add its plugin ID and value key(s) to the `$t` map inside
`getVisibility()`. There is no config or hook to do this without subclassing/patching. Because the
integration is a single `setListBuilderClass()` call, a downstream module that also overrides the
`block` list builder in `hook_entity_type_alter()` will conflict (last hook wins) — subclass this
class instead of replacing it.
