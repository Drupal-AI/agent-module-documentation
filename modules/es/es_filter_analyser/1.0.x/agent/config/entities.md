<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities: es_filter and es_analyser

## Install & enable

```bash
composer require drupal/es_filter_analyser
drush en es_filter_analyser -y
```

Pulls in `search_api` and `elasticsearch_connector` (composer `^8.0 || ^9.0`). On install the module
imports three example config objects from `config/install/`:
`es_filter_analyser.filter.lowercase`, `es_filter_analyser.filter.fr_elision` and
`es_filter_analyser.analyser.fr_text` (a French text analyser: tokenizer `standard`, filters
`lowercase` + `fr_elision`).

## es_filter — `Entity\Filter`

`@ConfigEntityType(id = "es_filter", config_prefix = "filter", admin_permission = "administer es_filter_analyser")`.
Represents **one native ElasticSearch token filter**. `config_export`: `id`, `label`, `type`,
`settings`.

- `type` (string) — the `FilterType` plugin id (see [../plugins/filter-types.md](../plugins/filter-types.md)),
  e.g. `stemmer`, `synonym`, `edge_ngram`, `lowercase`.
- `settings` (array) — the plugin's ES filter parameters.
- `getConfigData()` returns `$settings + ['type' => $type]` — the exact array handed to ES as one
  entry under `analysis.filter.<id>`.
- Handlers: list builder `FilterListBuilder` (columns Filter / Machine name / Type), forms
  `FilterForm` (add/edit) + core `EntityDeleteForm`, `AdminHtmlRouteProvider`.

Config object shape (`es_filter_analyser.filter.fr_elision`):

```yaml
id: fr_elision
label: 'French Elision'
type: elision
settings:
  articles_case: true
  articles: [l, m, t, qu, n, s, j, d, c, jusqu, quoiqu, lorsqu, puisqu]
```

## es_analyser — `Entity\Analyser`

`@ConfigEntityType(id = "es_analyser", config_prefix = "analyser", admin_permission = "administer es_filter_analyser")`.
Represents an **analyser** = a tokenizer plus an ordered list of filters. `config_export`: `id`,
`label`, `tokenizer`, `filters`.

- `tokenizer` (string) — one of the ES tokenizers offered by `AnalyserForm::getTokenizerOptions()`
  (standard, letter, lowercase, whitespace, uax_url_email, ngram, edge_ngram, keyword, pattern,
  simple_pattern, char_group, simple_pattern_split, path_hierarchy, thai, icu_tokenizer,
  kuromoji_tokenizer, nori_tokenizer).
- `filters` (array) — an **ordered list of `es_filter` ids** (list, not keyed). `AnalyserForm::save()`
  rebuilds it from the drag-and-drop weight table with `ksort()` then `array_values()`.
- `getConfigData()` returns `['tokenizer' => ..., 'filter' => [...ids]]` — the entry handed to ES as
  `analysis.analyzer.<id>`.
- Handlers: `AnalyserListBuilder` (Analyser / Machine name / Tokenizer), `AnalyserForm`,
  `EntityDeleteForm`, `AdminHtmlRouteProvider`.

`AnalyserForm` builds a `#tabledrag` table of the current filters (add via a select of not-yet-added
filters, remove via per-row AJAX submit); the tokenizer is a required select defaulting to `standard`.
`FilterForm` picks a `FilterType` via `filterTypeManager->getFilterTypeOptions()`, then AJAX-rebuilds a
`settings` subform from the chosen plugin's `buildConfigurationForm()`; on save it runs
`plugin->processPluginSettings()` (→ `submitConfigurationForm()`) to normalise the stored settings.

## Routes, permissions, menus

- Effective admin permission for both types is **`administer es_filter_analyser`** (each entity's
  `admin_permission`; defined in `es_filter_analyser.permissions.yml`, `restrict access: true`).
- The entity annotations declare `AdminHtmlRouteProvider` with **singular** link paths
  (`/admin/config/search/analyser`, `/admin/config/search/filter` and their `add`/`{id}/edit`/`delete`
  routes), yielding route names `entity.es_analyser.collection`, `entity.es_analyser.add_form`, etc.
- `es_filter_analyser.links.action.yml` adds "Add analyser" / "Add filter" actions on the collections;
  `es_filter_analyser.links.menu.yml` adds two items under *Configuration → Search and metadata*.
- **Caveat (source inconsistency, not a behaviour to rely on):** `es_filter_analyser.routing.yml`
  additionally declares **plural**-path routes (`/admin/config/search/analysers`, `.../filters`) whose
  `_title_callback`s point at `Controller\AnalyserController` / `Controller\FilterController` and whose
  requirements reference permissions such as `administer es_filter entities` / `create es_filter entities`.
  Those controller classes are **not present** in the module and those permissions are **not defined**
  anywhere, so those declared routes cannot resolve/authorise. Rely on the entity-provider routes and
  the `administer es_filter_analyser` permission; verify the exact admin paths in-site after enabling.
