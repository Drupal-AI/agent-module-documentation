<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FilterType plugin type & catalog

The module defines its own annotation plugin type **`FilterType`** so each native ElasticSearch token
filter is a plugin that supplies a settings form and normalises its settings for storage on an
`es_filter` entity.

## Plugin type infrastructure

- Manager: `Plugin\FilterTypeManager` (service `plugin.manager.filter_type`, `parent: default_plugin_manager`).
  Discovers `Plugin/FilterType/*` classes implementing `FilterTypeInterface` annotated with
  `Annotation\FilterType`; alter hook `filter_type_info`; cache key `filter_type_plugins`.
  `getFilterTypeOptions()` → `[id => label]` used by `FilterForm`.
- Annotation `Annotation\FilterType` — fields `id`, `label`, `description`.
- Base class `Plugin\FilterTypeBase` (extends `PluginBase`): `label()`, `description()`,
  `buildConfigurationForm(form, form_state, configuration = [])` (default returns form unchanged),
  `validateConfigurationForm()`, `submitConfigurationForm(values)` (default `[]`),
  `defaultConfiguration()` (default `[]`), and `processPluginSettings()` which calls
  `submitConfigurationForm($form_state->getValue('settings'))`. The returned array is stored verbatim as
  the `es_filter` entity's `settings` and later shipped to ES via `Filter::getConfigData()`.

To add a custom filter, drop a class in `src/Plugin/FilterType/` with a `@FilterType` annotation and
implement `buildConfigurationForm()` / `submitConfigurationForm()` (+ optional `validateConfigurationForm()`).

## Shipped plugins (31, in `src/Plugin/FilterType/`)

| id | label | id | label |
|---|---|---|---|
| `apostrophe` | Apostrophe | `keyword_marker` | Keyword Marker |
| `asciifolding` | ASCII Folding | `kstem` | KStem |
| `cjk_bigram` | CJK Bigram | `length` | Length |
| `cjk_width` | CJK Width | `limit` | Limit |
| `common_grams` | Common Grams | `lowercase` | Lowercase |
| `decimal_digit` | Decimal Digit | `ngram` | N-Gram |
| `edge_ngram` | Edge N-Gram | `porter_stem` | Porter Stem |
| `elision` | Elision | `remove_duplicates` | Remove Duplicates |
| `fingerprint` | Fingerprint | `reverse` | Reverse |
| `keep` | Keep | `shingle` | Shingle |
| `keep_types` | Keep Types | `snowball` | Snowball |
| `stemmer` | Stemmer | `stemmer_override` | Stemmer Override |
| `stop` | Stop | `synonym` | Synonym |
| `synonym_graph` | Synonym Graph | `trim` | Trim |
| `truncate` | Truncate | `unique` | Unique |
| `uppercase` | Uppercase | | |

## Representative settings (from each plugin's defaultConfiguration/buildConfigurationForm)

- **`stemmer`** (`Stemmer.php`): `language` select (~40 options: english, light_english, french,
  german, russian, spanish, ...), default `english`.
- **`edge_ngram`** (`EdgeNGram.php`): `min_gram` (int, default 1), `max_gram` (int, default 2),
  `side` (`front`/`back`), `preserve_original` (bool). Validates `min_gram <= max_gram`.
- **`synonym`** (`Synonym.php`): `synonyms` (textarea → array of trimmed rule lines), `expand` (bool,
  default true), `lenient` (bool). `synonym_graph` is the multi-word graph variant.
- **`elision`** (`Elision.php`): `articles` list + `articles_case` (see the `fr_elision` install config).
- **No-setting filters** (e.g. `lowercase`, `uppercase`, `trim`, `reverse`, `asciifolding`,
  `remove_duplicates`, ...): `buildConfigurationForm()` just renders an info `#markup` and stores `[]`;
  `getConfigData()` then emits `{ type: <id> }` with no extra keys.

Each stored `settings` array plus `type` is what `Filter::getConfigData()` returns and what lands under
`analysis.filter.<filter_id>` in the ElasticSearch index settings — so the keys must match the native ES
token-filter parameter names.
