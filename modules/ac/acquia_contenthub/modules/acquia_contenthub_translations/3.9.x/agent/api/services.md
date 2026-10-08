# API — translation tracking services & tables

Defined in `acquia_contenthub_translations.services.yml`. These track, per entity UUID, which
translations exist locally and what syndication is allowed to do with them.

| Service id | Class | Role |
|---|---|---|
| `acquia_contenthub_translations.manager` | `EntityTranslationsManager` (`EntityTranslationManagerInterface`) | Facade over the two DAOs: track/update/delete entities and their translations. |
| `acquia_contenthub_translations.tracking` | `Data\EntityTranslationsTracker` | DAO for the tracking table (one row per entity). |
| `acquia_contenthub_translations.entity` | `Data\EntityTranslations` | DAO for the per-translation table. |
| `acquia_contenthub_translations.undesired_language_registrar` | `UndesiredLanguageRegistrar` (`UndesiredLanguageRegistryInterface`) | Manage the `undesired_languages` config list. |
| `acquia_contenthub_translations.translation_facilitator` | `TranslationFacilitator` | Bridges `hook_entity_*` into the manager (`trackTranslation()`). |
| `acquia_contenthub_translations.translatable_entity_filter` | `TranslatableEntityFilter` | `filterEntityUuidsBySubscriberLanguages()` — keep only UUIDs relevant to the site's languages. |
| `acquia_contenthub_translations.handler.deletion` / `.handler.update` | `OperationHandler\TranslationDeletionHandler` / `TranslationUpdateHandler` | Apply delete/update tracking on `hook_entity_*` and CDF parse. |
| `acquia_contenthub_translations.nt_entity_handler.registry` | `EntityHandler\HandlerRegistry` | Maps `entity_type:bundle` ⇒ handler id (see plugins doc). |
| `acquia_contenthub_translations.nt_entity_handler.context` | `EntityHandler\NonTranslatableEntityHandlerContext` | Dispatches a CDF object to the resolved non-translatable handler. |

## EntityTranslationManagerInterface (`acquia_contenthub_translations.manager`)

Operation flags on a tracked translation: `NO_ACTION = 0`, `NO_DELETION = 1`, `NO_UPDATE = 2`.

```php
$mgr = \Drupal::service('acquia_contenthub_translations.manager');
// Track an entity (uuid, type, original default langcode, local default langcode):
$tracked = $mgr->trackEntity($uuid, 'node', 'en', 'en');
// Track / remove a specific translation with an operation flag:
$mgr->trackTranslation($uuid, 'de', EntityTranslationManagerInterface::NO_DELETION);
$mgr->removeTranslation($uuid, 'de');
$tracked = $mgr->getTrackedEntity($uuid);   // ?TrackedEntity
$mgr->updateTrackedEntity($tracked);
$mgr->deleteTrackedEntity($uuid);           // removes from both tables
$mgr->trackMultiple($values);
```

## Undesired languages (`...undesired_language_registrar`)

```php
$reg = \Drupal::service('acquia_contenthub_translations.undesired_language_registrar');
$reg->markLanguagesUndesired('fr', 'es');
$reg->isLanguageUndesired('fr');            // bool
$reg->getUndesiredLanguages();              // string[]
$reg->removeLanguageFromUndesired('fr');    // also called on configurable_language delete
```

## Database tables (created in `hook_schema`)

- **`acquia_contenthub_entity_translations_tracking`** (`EntityTranslationsTracker::TABLE`) — one
  row per entity: `id` (serial), `entity_uuid` (unique), `entity_type`, `original_default_language`,
  `default_language`, `created`, `changed`. Collation `utf8_bin`.
- **`acquia_contenthub_entity_translations`** (`EntityTranslations::TABLE`) — one row per
  translation: `id` (serial), `entity_uuid`, `langcode`, `operation_flag` (int; the NO_ACTION /
  NO_DELETION / NO_UPDATE flag), `created`, `changed`. Unique key `uuid_langcode`
  (`entity_uuid`, `langcode`).

The `.module` hooks (`entity_insert/update/presave`, `entity_translation_insert/delete`,
`entity_delete`, `configurable_language_delete`) call the facilitator and the deletion/update
handlers to keep these tables in sync with local content changes.
