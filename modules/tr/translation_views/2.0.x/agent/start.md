# Translation Views — agent index

Adds Views **fields & filters** describing each row's translation into a chosen **target
language** (status, outdated, count, operations, moderation, ...). No settings form
(`configure=null`), no permissions, no Drush, no own config. Depends on `content_translation` +
`views`. Fields appear **only** for entity types with content translation enabled.

- **The Views tables/fields/filters it adds, plugin ids, the target-language mechanism, the demo view** →
  [configure/views-integration.md](configure/views-integration.md)

Key facts:
- `hook_views_data_alter()` adds tables `{entity}_translation` and `{entity}_translation_target`,
  joined via `translation_views_language_join`, for translatable + content_translation-enabled
  entity types.
- Signature exposed filter/field: **`translation_views_target_language`** (table
  `{entity}_translation`, exposed identifier `translation_target_language`).
- Other plugin ids: `translation_views_status`, `translation_views_translation_count`,
  `translation_views_operations`, `translation_views_source_equals_row`,
  `translation_moderation_state` (+ core `date`/`boolean` handlers for changed/outdated).
- Runtime substitution tokens `***TRANSLATION_VIEWS_TARGET_LANG***` /
  `***TRANSLATION_VIEWS_TARGET_LIMIT_LANG***` (`hook_views_query_substitutions()`).
- Demo view `content_translations` (config/optional) at `/translate/content`.
