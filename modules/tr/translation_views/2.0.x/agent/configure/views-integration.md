# Views integration — tables, fields, filters

No admin settings (`configure=null`). Everything is done in the **Views UI**; the module only
adds Views data. Fields/filters appear **only for entity types that are translatable AND have
content_translation enabled** — enable content translation for the entity type first, or the
handlers won't exist (and a view referencing them can't be built in the UI).

## Tables added (`hook_views_data_alter`)

For each qualifying entity type, keyed off its base data table (e.g. `node_field_data`):

- **`{entity}_translation`** — joined via the custom join `translation_views_language_join`
  (a `GROUP_CONCAT`/`COUNT` subquery of langcodes per row).
- **`{entity}_translation_target`** — LEFT-joined with an extra condition on
  `langcode = ***TRANSLATION_VIEWS_TARGET_LANG***` (the chosen target language).

## Fields / filters (plugin ids)

| Plugin id | Table | Kind | Meaning |
|---|---|---|---|
| `translation_views_target_language` | `{entity}_translation` | field + **filter** | The target language selector; as a filter it's exposed (identifier `translation_target_language`). Has a "remove rows where language equals target" option. |
| `translation_views_status` | `{entity}_translation` | field + filter | Is the row translated into the target language (boolean). |
| `translation_views_translation_count` | `{entity}_translation` | field + filter | Number of translations (filterable by amount; option to include original language). |
| `translation_views_operations` | `{entity}_translation` | field | Add/edit translation operation links for the target language. |
| `translation_moderation_state` | `{entity}_translation` | field | Target-language moderation state (only when `content_moderation` is on). |
| `translation_views_source_equals_row` | `{entity}_translation_target` | field + filter | Source translation of the row equals the target language. |
| `translation_outdated` (core `boolean`) | `{entity}_translation_target` | field + filter | Target-language translation is outdated. |
| `translation_changed` (core `date`) | `{entity}_translation_target` | field | Time the target-language translation was last changed. |
| `translation_default_langcode` | `{entity}_translation_target` | field + filter | Target language equals the row's default (original) language. |

All these live under the Views group **"{Entity} translation"**.

## Target-language mechanism

- Add the **`translation_views_target_language`** filter and expose it. Its exposed identifier is
  `translation_target_language`; the user's choice drives which language the `_target` fields
  report on.
- At query time, `hook_views_query_substitutions()` replaces the placeholders
  `***TRANSLATION_VIEWS_TARGET_LANG***` and `***TRANSLATION_VIEWS_TARGET_LIMIT_LANG***` with the
  selected langcode (defaulting to the site default language when nothing is chosen).
- `translation_views_query_views_alter()` (a `hook_query_TAG_alter` for tag `views`) makes those
  substitutions also apply inside `addField()`/`addOrderBy()` expressions.

## In a view's config

A translation_views handler in `display.<id>.display_options.filters` (or `.fields`) looks like:

```yaml
filters:
  translation_target_language:
    id: translation_target_language
    table: node_translation
    field: translation_target_language
    plugin_id: translation_views_target_language
    entity_type: node
    exposed: true
    expose:
      identifier: translation_target_language
```

Field example (`fields:`): `plugin_id: translation_views_status`, `table: node_translation`.

## Demo view

`content_translations` (shipped as `config/optional`, so it installs only when its dependencies
are met) provides the **"Content translation jobs"** page at `/translate/content` — a ready-made
node translation dashboard you can clone for other entity types.
