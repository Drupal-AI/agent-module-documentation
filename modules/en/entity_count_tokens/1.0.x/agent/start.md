<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Count Tokens (entity_count_tokens) — agent index

Adds a **Token** integration that resolves the number of entities of a given type/bundle. Version
**1.0.0**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. No package declared, **no
composer.json**, **no dependencies** (info.yml lists none; contrib **Token Filter** is only needed
to render tokens inside formatted-text fields).

- **The token type, syntax, and how counts are computed** →
  [tokens/tokens.md](tokens/tokens.md)

## What it actually is

- A single hook file `entity_count_tokens.tokens.inc` implementing **`hook_token_info()`** and
  **`hook_tokens()`**, plus one controller `EntityCountTokensController`
  (`src/Controller/EntityCountTokensController.php`, extends core `ControllerBase`).
- Token type **`entity_count_token`**. Replacement syntax: `[entity_count_token:ENTITY_TYPE]` for
  single-bundle types, `[entity_count_token:ENTITY_TYPE:BUNDLE]` for multi-bundle types (README
  examples: `[entity_count_token:node:article]`, `[entity_count_token:product:book]`).
- **No routes**, no `*.routing.yml`, no `*.services.yml` (the controller is built via
  `ControllerBase::create()` directly inside the hooks), no `*.install`, no config objects, and
  **no config schema** (no `config/` directory).
- Declares one permission **`access entity count tokens`** in `entity_count_tokens.permissions.yml`
  that is **not referenced anywhere in code** (no route uses it; the token hooks do not check it).

## Counting (from source)

- `EntityCountTokensController::entityCountRaw()` builds a nested array keyed by entity-type id then
  bundle id. Content entities use `getAggregateQuery()->accessCheck(TRUE)->count()->execute()`;
  config entity types (`ConfigEntityType`) use `loadMultiple()` count. Multi-bundle types get a
  per-bundle count via `getQuery()->condition(bundle_key, bundle_id)->accessCheck(TRUE)->count()`.
- `hook_tokens()` walks that nested array by splitting the token name on `:`.
- `EntityCountTokensController::generateAllTokens()` only advertises token names for the token
  browser (with a different, cosmetic naming scheme) — see the caveat in
  [tokens/tokens.md](tokens/tokens.md).
