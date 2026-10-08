<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `select_translation_filter` Views filter

The module's whole UI surface. `hook_views_data_alter()` registers a filter on the
`node_field_data` table:

- table: `node_field_data`
- field key: `select_translation`
- **plugin id: `select_translation_filter`** (the `@ViewsFilter("select_translation_filter")` handler `Drupal\select_translation\Plugin\views\filter\SelectTranslation`)
- title: "Select translation"

It is a no-operator filter (`$no_operator = TRUE`) — there is no exposed value/operator,
just a selection mode you pick in the filter's options form.

## Options (stored inline on the view display filter)

| Option key | Meaning | Default |
|---|---|---|
| `value` | selection mode: `original`, `default`, `fallback`, or `list` | `default` |
| `priorities` | comma-separated language codes, used only when `value` = `list` | `''` |
| `default_language_only` | when current language == site default, show default-language content only (ignores the order) | `0` |
| `include_content_with_unpublished_translation` | also return the default-language node when the current-language translation exists but is unpublished (pair with a `Published = Yes` filter) | `0` |

### The four modes (`value`)

- `original` — current interface language; else the node's original language.
- `default` — current interface language; else site default language; else original.
- `fallback` — use core's language fallback candidate chain (`language_manager::getFallbackCandidates`).
- `list` — custom priority: the `priorities` string is a comma-separated list of langcodes.
  Tokens `current` / `default` / `original` resolve to the current interface language, the
  site default language, and the node's original language. `original` is always appended as
  the final fallback, so a node is never dropped. Example: `en,fr,current,default,original`.

## Add it to a view via UI

Manage → Views → your node view → Add filter criterion → search "Select translation"
(Content: Select translation) → choose a selection mode → optionally fill Language
priorities / the two checkboxes.

## Add it to a view in code / config

The filter lives under `display.<display>.display_options.filters.select_translation` in the
`views.view.<id>` config entity. Programmatically:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$exec = $view->getExecutable();
$exec->setDisplay('default');
$filters = $exec->getDisplay()->getOption('filters');
$filters['select_translation'] = [
  'id' => 'select_translation',
  'table' => 'node_field_data',
  'field' => 'select_translation',
  'plugin_id' => 'select_translation_filter',
  'value' => 'list',              // original | default | fallback | list
  'priorities' => 'fr,en,current',// only used when value = list
  'default_language_only' => 0,
  'include_content_with_unpublished_translation' => 0,
];
$exec->getDisplay()->setOption('filters', $filters);
$view->save();
```

## How the query works (why it's fast)

Instead of correlated sub-queries, `query()` LEFT JOINs the `node_field_data` table once
per candidate language (each wrapped in a sub-select to survive node-access query rewrites,
e.g. Domain), then ORs together, per language in priority order, "this row is in language L
AND has no row in any earlier language". The `original` step matches rows where
`default_langcode = 1`. Net effect: one row per node, in the highest-priority available
language.
