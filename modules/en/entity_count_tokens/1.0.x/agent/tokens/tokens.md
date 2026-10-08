<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity count tokens

All logic lives in `entity_count_tokens.tokens.inc` and
`src/Controller/EntityCountTokensController.php` (`Drupal\entity_count_tokens\Controller\EntityCountTokensController`).

## Install / enable

`drush en entity_count_tokens`. No configuration, no settings form, no routes. To render the token
inside a formatted-text (WYSIWYG/body) field, also enable the contrib **Token Filter** module and
add its filter to the text format — otherwise the token only resolves in contexts that natively run
token replacement (block/field settings, message templates, etc.).

## Token type and syntax

`hook_token_info()` (`entity_count_tokens_token_info()`) registers one token type
**`entity_count_token`** (label *"Entity counts"*). Replacement syntax:

- `[entity_count_token:ENTITY_TYPE]` — for entity types that have **one bundle or none** (e.g.
  `[entity_count_token:user]`).
- `[entity_count_token:ENTITY_TYPE:BUNDLE]` — for entity types with **more than one bundle** (e.g.
  `[entity_count_token:node:article]`, README example `[entity_count_token:product:book]`).

## How a token is resolved

`hook_tokens()` (`entity_count_tokens_tokens()`) runs only when `$type == 'entity_count_token'`:

1. Calls `EntityCountTokensController::entityCountRaw()` once to get the nested count array.
2. For each requested token, `explode(':', $name)` and walks into the array by each part, so
   `node:article` reads `$counts['node']['article']` and `user` reads `$counts['user']`.
3. Returns the integer count as the replacement value.

## Counting logic — `entityCountRaw()`

Iterates every entity-type definition from `entity_type.manager`:

- **Config entity types** (`get_class($definition) == 'Drupal\Core\Config\Entity\ConfigEntityType'`):
  count = `count($storage->loadMultiple())` (no access filtering — config entities).
- **Content entity types**: `$storage->getAggregateQuery()->accessCheck(TRUE)->count()->execute()`,
  so the count reflects the **current user's view access**.
- If the type reports **more than one bundle** (`entity_type.bundle.info`): a per-bundle count is
  run with `getStorage()->getQuery()->condition($bundle_key, $bundle_id)->accessCheck(TRUE)
  ->count()->execute()`, stored at `$rows[$type][$bundle]`. `$bundle_key` comes from
  `$definition->getKeys()['bundle']` (falls back to the literal `'bundle'`).
- Otherwise the single count is stored at `$rows[$type]`.

All queries use the entity query API with a bundle id sourced from `getBundleInfo()` (not user
input), so there is no hand-built SQL.

## Token discovery — `generateAllTokens()`

Used **only** by `hook_token_info()` to list available tokens for the token browser. It emits names
in a different, cosmetic scheme — `"entity_count_tokens:$type:$bundle"` for multi-bundle types and
`"entity_count_tokens.$type"` for single-bundle types — and registers them under the core
**`entity`** token group. These advertised names do **not** match the working replacement syntax
`[entity_count_token:...]` used at resolution time, so treat the token-browser listing as cosmetic
and rely on the `[entity_count_token:TYPE(:BUNDLE)]` form documented above.

## Notes

- The permission `access entity count tokens` (in `entity_count_tokens.permissions.yml`) is declared
  but never checked in code; token replacement does not gate on it.
- Output is an integer count; it flows through core's normal token/render escaping.
