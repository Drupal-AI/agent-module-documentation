<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Views area handlers

The module registers two Views **area** handlers (via `hook_views_data()` in
`search_api_spellcheck.views.inc`) on the pseudo-table `views`. They are placed in the **Header**
or **Footer** of a Search API view (a view whose base table is a Search API index). There is no
plugin manager and no new plugin type — these are instances of core's `views_area` plugin type.

| Plugin id (`@ViewsArea`) | Class | Renders |
|---|---|---|
| `search_api_spellcheck_did_you_mean` | `DidYouMeanSpellCheck` | one best-guess "Did you mean: <link>?" |
| `search_api_spellcheck_suggestions` | `SuggestionsSpellCheck` (extends the above) | a `<ul>` of keyword-variation links |

## Options (config keys)

Defined in `defineOptions()` and validated by `config/schema/search_api_spellcheck.schema.yml`
(`views.area.search_api_spellcheck_did_you_mean` / `..._suggestions`):

| Key | Type | "Did you mean" default | "Suggestions" default | Meaning |
|---|---|---|---|---|
| `search_api_spellcheck_count` | integer | 1 | 1 | Max suggestions the backend returns per term. |
| `search_api_spellcheck_hide_on_result` | boolean | TRUE | TRUE | Render only when the view has **no** results (`$empty`). |
| `search_api_spellcheck_collate` | boolean | TRUE | **FALSE** | Ask the backend to build one corrected phrase (Solr collation). |

The "Did you mean" options form exposes only `hide_on_result` as a checkbox; the "Suggestions"
form adds a `count` number field. `collate` is set via defaults/config.

## Backend requirement (why it can render nothing)

In `query()` the handler acts only when
`$this->query instanceof SearchApiQuery` **and**
`$query->getIndex()->getServerInstance()->supportsFeature('search_api_spellcheck')`. Solr
(`search_api_solr`) advertises this feature; the core **Database** backend does **not**, so on a
DB-backed index the handlers attach no query option and render `[]`. It then sets the
`search_api_spellcheck` query option (`keys`, `count`, `collate`). If the fulltext parse mode
yields non-array keys it throws `InvalidArgumentException` ("parse mode … not compatible").

## Render behaviour

At render time it reads `$result->getExtraData('search_api_spellcheck')`:
- **Did you mean** — uses `spellcheck['collation']` if present, else replaces each mis-spelled
  token with its top `suggestions[key][0]`; emits one link only if the corrected phrase differs
  from the typed keys. Suppressed when the view has results unless `hide_on_result` is FALSE.
- **Suggestions** — expands `spellcheck['suggestions']` into every combination (an "odometer"
  over the per-token suggestion lists) and emits one link per variation.

Each link re-runs the current view URL with the corrected phrase placed in the **exposed
`SearchApiFulltext` filter's** parameter (`getFilterFieldKey()`), preserving other query params.

## Add a handler to a view (config shape)

The handler lives under a display's `display_options.header` (or `footer`) in `views.view.<id>`:

```yaml
display:
  default:
    display_options:
      header:                       # or footer:
        search_api_spellcheck_did_you_mean:
          id: search_api_spellcheck_did_you_mean
          table: views
          field: search_api_spellcheck_did_you_mean
          plugin_id: search_api_spellcheck_did_you_mean
          search_api_spellcheck_count: 3
          search_api_spellcheck_hide_on_result: true
          search_api_spellcheck_collate: true
```

Via the UI: edit the Search API view → **Header** (or Footer) → **Add** → choose
*Search API Spellcheck "Did You Mean"* or *"Suggestions"* → set the options → Save.

Scriptable (drush php:eval):

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_search');
$d = $view->getDisplay('default');
$d['display_options']['header']['search_api_spellcheck_did_you_mean'] = [
  'id' => 'search_api_spellcheck_did_you_mean', 'table' => 'views',
  'field' => 'search_api_spellcheck_did_you_mean',
  'plugin_id' => 'search_api_spellcheck_did_you_mean',
  'search_api_spellcheck_count' => 3,
  'search_api_spellcheck_hide_on_result' => TRUE,
  'search_api_spellcheck_collate' => TRUE,
];
$view->set('display', ['default' => $d] + $view->get('display'))->save();
```

Read it back: `drush cget views.view.my_search display.default.display_options.header`.

Note: update hook `search_api_spellcheck_update_9002` renamed the legacy mis-spelled plugin id
`search_api_spellcheck_suggetions` → `search_api_spellcheck_suggestions` in existing view config.
