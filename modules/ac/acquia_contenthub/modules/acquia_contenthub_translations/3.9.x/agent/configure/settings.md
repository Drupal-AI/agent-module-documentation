# Configure — selective language import

Settings form **`ContentHubTranslationsSettingsForm`** (form id
`acquia_contenthub_translations_settings`) at
`/admin/config/services/acquia-contenthub/translations`
(route `acquia_contenthub_translations.settings`), shown as a local task under the base Content
Hub settings and gated by the parent's `_contenthub_ui_access` check.

Config object: **`acquia_contenthub_translations.settings`**
(schema in `config/schema/acquia_contenthub_translations.schema.yml`).

| Key | Type | Meaning |
|---|---|---|
| `selective_language_import` | boolean | Master switch — import only desired languages, pruning the rest from incoming CDF. |
| `override_translation` | boolean | Allow syndication to overwrite a translation that was modified locally. |
| `undesired_languages` | sequence of langcode | Languages present only because of a hard dependency; excluded from syndication where possible. Managed by the registrar, shown read-only (disabled) on the form. |
| `nt_entity_registry.unspecified` | sequence | Non-translatable entities not yet classified (`entity_type:bundle` ⇒ `unspecified`). |
| `nt_entity_registry.handler_mapping` | sequence | Non-translatable entities mapped to a handler id (`entity_type:bundle` ⇒ handler id). |
| `nt_override_registry` | sequence | Non-translatable `entity_type:bundle` entries flagged as overridden. |

The form itself only writes `selective_language_import` and `override_translation`; the registry
keys are maintained programmatically (see [api/services.md](../api/services.md) and
[plugins/nt-entity-handler.md](../plugins/nt-entity-handler.md)). Set the two toggles via Drush:
```
drush cset acquia_contenthub_translations.settings selective_language_import 1
drush cset acquia_contenthub_translations.settings override_translation 0
```

## What happens at runtime

On the subscriber, incoming CDF is filtered by the site's languages before entities are saved:

- **`PruneLanguagesFromCdf`** (on `PRUNE_CDF`) removes undesired/foreign languages from the CDF
  document, keeping only languages enabled on this site (via `LanguageManager` +
  `UndesiredLanguageRegistrar`), and defers to the non-translatable entity handler context for
  entities that are not translatable.
- **`DeleteUndesiredTranslations`** (on `PARSE_CDF`) deletes translations the site did not request
  through `TranslationDeletionHandler`.
- **`NormalizeFieldValues`** (on `ENTITY_DATA_TAMPER`) normalizes field values across languages
  using the translation manager's tracked data.
- The webhook-handler decorators and the `entity_upsert` queue-action decorator filter candidate
  UUIDs by subscriber languages using `TranslatableEntityFilter::filterEntityUuidsBySubscriberLanguages()`.

`hook_install` warns that the publisher must re-export content so the CDF metadata carries the
`translatable` attribute (`drush acquia:contenthub-re-queue --use-tracking-table`). Update
`acquia_contenthub_translations_update_82001` migrated old `entity_type ⇒ handler` config to the
`entity_type:bundle ⇒ handler` format.
