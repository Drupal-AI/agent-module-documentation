<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How token_custom replacement works

All in `token_custom.module` plus the two entity classes. No plugin types, no services of its own.

## Advertising tokens — `hook_token_info()`

`token_custom_token_info()` loads every `token_custom_type` and exposes it under `types`, and
every `token_custom` entity under `tokens[<bundle>][<machine_name>]` (with name + description).
This is what makes them show up in the Token browser and be known to Token-aware modules.

## Replacing tokens — `hook_tokens()`

`token_custom_tokens($type, $tokens, …)`:

1. Reads the allow-list of valid type ids (`token_custom_type_allowlist()`).
2. If `$type` is an allowed token type, loads the requested `token_custom` entities.
3. For each token whose bundle matches `$type`, sets the replacement to
   `$token_custom->getFormattedContent()` = `check_markup($content->value, $content->format)`
   (so the token's text format is applied — rich HTML is supported).
4. Adds the token entity as a cacheable dependency (`$bubbleable_metadata->addCacheableDependency`)
   and, for translatable tokens, resolves the translation for the current/`$options['langcode']`.

## The allow-list cache

`token_custom_type_allowlist($rebuild = FALSE)`:

- Backed by cache id **`token_custom.allowlist`** (PERMANENT), tagged with the
  `token_custom_type` list cache tags.
- Returns the set of token-type ids via an entity query.
- Rebuilds automatically when a token *type* is created/updated/deleted (list cache tag
  invalidation), so newly added types resolve without a manual `drush cr`.

## Entity content accessors (`TokenCustom`)

| Method | Returns |
|---|---|
| `getRawContent()` | the stored `content` value (unformatted) |
| `getFormattedContent()` | `check_markup(value, format)` — used for the actual replacement |
| `getFormat()` | the text format id (falls back to `filter_default_format()`) |
| `getDescription()` | the description |
| `bundle()` | the token type machine name (e.g. `custom`) |

Entity keys: `id = machine_name`, `bundle = type`, `label = name`, `langcode = langcode`;
`admin_permission = "administer custom tokens"`.
