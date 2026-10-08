<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, group field, tokens & hooks

## Service `alpha_numeric_glossary`

Class `Drupal\alpha_numeric_glossary\AlphaNumericGlossary` (`alpha_numeric_glossary.services.yml`).
Constructor deps: `entity_field.manager`, `language_manager`, `module_handler`, `cache.default`,
`transliteration`, `database`, `token`, `string_translation`, `path.current`. It is a stateful
per-View helper — the area/field plugin calls `setHandler($this)` to bind the current Views
handler, so treat it as an internal collaborator of the plugins, not a general-purpose API. Key
methods:

- `getAlphabet($langcode)` / `getNumbers($langcode)` — return the character/number sets. Ship
  `en` (A-Z, or a-z when `glossary_case_text` is lowercase), `ar` (Arabic), `ru` (Russian);
  unknown langcodes fall back to English default. Both fire the alter hooks below; alphabets are
  cached (cid `alpha_numeric_glossary:alphabets`).
- `getCharacters()` — builds the ordered map of `AlphaNumericGlossaryCharacter` objects (alphabet
  + optional numeric + optional "All" + optional counts), marks which are **enabled** (have
  content) and which is **active** (matches the current View arg).
- `getEntityIds()` / `getEntityPrefixes($count, $case_text)` — determine which first-characters
  have content: re-extracts the View's compiled SQL (`ensureQuery()`), neutralizes the glossary
  contextual-filter's `SUBSTRING` condition and the `LIMIT` so counting spans the whole result
  set, runs it to get entity ids, then `SELECT [DISTINCT] SUBSTR(field,1,1)` over the field's
  table for those ids. First characters are transliterated + case-folded. Field/table are derived
  from `glossary_view_field` and the View's base-table storage (admin config, not request input);
  arguments are `Connection::quote()`d.
- `getUrl()` / `getTokens($value)` — compute the base path and the token data
  (`alpha_numeric_glossary:path`, `:value`) used to build each link.
- `getLabel($value)` / `getValue($value)` / `isNumeric($value)` — label/value/type resolution.
- `addClasses($classes, &$attributes)` — split + `Html::cleanCssIdentifier` a class string into an
  attributes array (used everywhere classes are applied).
- `parseAttributes($string, $tokens)` — parse the `key|value,...` attribute option (token-replaced).
- `validate()` — enforces exactly one glossary area per display (called by both plugins).
- `getOption($name, $default='')` — reads `$handler->options[$name]` as a string.

## `AlphaNumericGlossaryCharacter` value object

`src/AlphaNumericGlossaryCharacter.php`. One per character. `build($render=false)` returns a link
render array (`buildLink()`) when `isLink()` else an html_tag `<span>`. `isLink()` =
not-active AND (enabled OR "all"). `isEnabled()` = "all" OR active OR has-content. `buildLink()`
token-replaces `glossary_link_path`, wraps it as `internal:/…` unless external/anchor, applies
`glossary_link_class` + parsed attributes, and (when count is on) appends ` <sup>(n)</sup>`.

## Group field `alpha_numeric_glossary_group`

`src/Plugin/views/field/AlphaNumericGlossaryGroup.php` (`@ViewsField`, extends
`FieldPluginBase`). An automated, excluded-by-default field. `query()` is empty (doesn't touch the
SQL). `render(ResultRow)` finds the glossary area handler, renders the configured
`glossary_view_field` for the row, and returns the **first character** of the stripped value
(`Unicode::ucfirst(substr(strip_tags($field->last_render),0,1))`) as its group label — used as a
Views *grouping field* so rows cluster under their first letter. If the link path starts with `#`
it emits an `<a name>` anchor instead.

## Tokens (`alpha_numeric_glossary.module`)

`hook_token_info` + `hook_tokens` register token type `alpha_numeric_glossary` with `path` (current
view/page path) and `value` (current character). `alpha_numeric_glossary_tokens()` applies the
`glossary_case_link` case function to the value and `Html::escape()`s it when sanitizing. These
tokens are what `glossary_link_path` uses. `AlphaNumericGlossary::buildTokenTree()` renders the
token browser in the options form (uses contrib `token` module UI if present, else a plain list).

## Alter hooks (`alpha_numeric_glossary.api.php`)

- `hook_alpha_numeric_glossary_alphabet_alter(array &$alphabets, $view)` — add/remove/replace
  characters per langcode before rendering (results are cached, so clear cache after changing).
- `hook_alpha_numeric_glossary_numbers_alter(array &$numbers, $view)` — same for the 0-9 set.

Always list characters explicitly (do not use `range()`), per the module's own guidance.

## Cache invalidation

`alpha_numeric_glossary_entity_presave()` (a `hook_entity_presave` implementation) invalidates the
cache tag `alpha_numeric_glossary:<entity_type>` on every content entity save, so glossary
enabled/count state refreshes when content changes.
