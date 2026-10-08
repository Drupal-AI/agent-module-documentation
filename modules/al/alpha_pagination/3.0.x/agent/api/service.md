<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, hooks & tokens

## Service `alpha_pagination` → `Drupal\alpha_pagination\AlphaPagination`

Defined in `alpha_pagination.services.yml`. Constructor args: `@entity_field.manager`,
`@language_manager`, `@module_handler`, `@cache.default`, `@transliteration`, `@database`, `@token`.
A shared helper used by both Views handlers; bind the active handler with `setHandler(ViewsHandlerInterface)`.
Implements `__sleep()`/`__wakeup()` to re-hydrate the handler from `view:display:type:field:lang`.

Key methods:

- `getCharacters()` — the core builder. Assembles alphabet + optional numeric items + optional "All"
  item into an ordered map of `AlphaPaginationCharacter` objects, marks which have content
  (`getEntityPrefixes()`), removes/keeps empty letters per `paginate_toggle_empty` /
  `paginate_numeric_hide_empty`, and sets the active character from the View's last argument. Result is
  cached (`cache.default`) under `getCid()`.
- `getCid()` — `alpha_pagination:` + hash of langcode/view/display/query/options; used for the
  per-view/display/query character cache.
- `getAlphabet($langcode)` / `getNumbers($langcode)` — return the character sets; English default,
  Arabic (`ar`) and Russian (`ru`) alphabets shipped; both cached (`alpha_pagination:alphabets`,
  `alpha_pagination:numbers`) and alterable (see hooks).
- `ensureQuery()` — captures the View's compiled SQL into the `query` option. Argument values from the
  compiled query are passed through `Connection::quote()` before substitution, then `Html::escape()`.
- `getEntityIds()` — reconstructs the View query (un-escapes HTML entities, removes any trailing
  `LIMIT`, short-circuits glossary `SUBSTRING` conditions with `1 OR`) and runs it to collect base-field
  ids across the full dataset.
- `getEntityPrefixes()` — `SELECT DISTINCT SUBSTR(field,1,1)` over the base/field table for those ids
  (ids bound via `:nids[]` placeholder), transliterating/uppercasing the first character.
- `getUrl()` / `getTokens()` / `getLabel()` / `getValue()` / `isNumeric()` — URL, token data and
  label/value resolution used when building links.
- `addClasses($classes, &$attributes)` — sanitizes class strings via `Html::cleanCssIdentifier()`.
- `parseAttributes($string, $tokens)` — parses `key|value,key|value` link-attribute strings with token
  replacement.
- `buildTokenTree()` — renders the available-token help (uses `token` module's tree link if present).
- `validate()` — enforces exactly one alpha-pagination area per display.

## Value object `Drupal\alpha_pagination\AlphaPaginationCharacter`

One per pagination item. Holds `label`/`value` and `active`/`enabled` flags. `build()` returns a
`#type => link` render array (`buildLink()`) for enabled/active-linkable characters — path built from
`paginate_link_path` via token replace, `Url::fromUri('internal:/…')` (or external/anchor), current
query string merged in, `class` stripped from parsed attributes — or a `span` `html_tag` for inactive
items. `isLink()`, `isAll()`, `isNumeric()`, `isEnabled()`, `isActive()` gate the state.

## Module file (`alpha_pagination.module`)

- `alpha_pagination_help()` — help text on `help.page.alpha_pagination`.
- `alpha_pagination_entity_presave()` — on any `ContentEntityInterface` save, invalidates cache tag
  `alpha_pagination:<entity_type_id>` so the paginator refreshes.
- `alpha_pagination_token_info()` / `alpha_pagination_tokens()` — define and replace the
  `alpha_pagination` token type with `path` and `value` tokens (escaped when `sanitize` is set).

## Alter hooks (`alpha_pagination.api.php`)

- `hook_alpha_pagination_alphabet_alter(array &$alphabets, $view)` — modify the per-langcode alphabet
  arrays before caching/rendering. Be explicit; do not use `range()`.
- `hook_alpha_pagination_numbers_alter(array &$numbers, $view)` — modify the per-langcode numbers array.

## Install / enable

`drush en alpha_pagination` (core `views` is the only dependency). Optionally
`drush en alpha_pagination_sample_view` for the bundled example. No permissions, routes or settings
form are added; configuration lives entirely on the Views area handler options.
