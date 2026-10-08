# acquia_contenthub_translations — agent start

**Experimental** submodule of **acquia_contenthub**. Lets a **subscriber** import only the
languages it wants of a syndicated entity: it prunes undesired languages from the incoming CDF,
tracks each entity's translations locally, and classifies non-translatable entities so mixed
translatable/non-translatable dependency graphs import correctly. Depends on `acquia_contenthub` +
`acquia_contenthub_subscriber`. Event/decorator-driven; no permissions or Drush.

- **Settings form, the config keys, selective-import behavior** → [configure/settings.md](configure/settings.md)
- **Services you call (translation manager, undesired-language registrar, handler registry) + the two DB tables** → [api/services.md](api/services.md)
- **The `nt_entity_handler` service-tag extension point + how to add one** → [plugins/nt-entity-handler.md](plugins/nt-entity-handler.md)

## Surfaces
- **Route** `acquia_contenthub_translations.settings` → `/admin/config/services/acquia-contenthub/translations`
  (`ContentHubTranslationsSettingsForm`), gated by the parent's `_contenthub_ui_access`; a local
  task under the base settings (`links.task.yml`).
- **Config** `acquia_contenthub_translations.settings`: `selective_language_import` (bool),
  `override_translation` (bool), `undesired_languages` (list), `nt_entity_registry` (mapping),
  `nt_override_registry` (list).
- **DB tables** `acquia_contenthub_entity_translations_tracking` and
  `acquia_contenthub_entity_translations` (created in `hook_schema`).
- **Hooks** (`.module`): `entity_insert/update/presave`, `entity_translation_insert/delete`,
  `entity_delete`, `configurable_language_delete` — feed the translation tracker.

## How it plugs into the pipeline (parent events, no hook API)
- `TrackTranslations` on `PARSE_CDF` (priority 1000) sets a static `isSyndicating` flag.
- `DeleteUndesiredTranslations` on `PARSE_CDF` removes locally-undesired translations via the
  deletion handler.
- `NormalizeFieldValues` on `ENTITY_DATA_TAMPER` normalizes imported field values.
- `PruneLanguagesFromCdf` on `PRUNE_CDF` drops undesired languages from the CDF document.
- Decorators: `ImportUpdateTranslatableAssets` / `ImportUpdateMultipleTranslatableAssets` decorate
  the subscriber's webhook import handlers; `TranslatableEntityUpsertAction` decorates the
  subscriber's `entity_upsert` queue action — all filtering by subscriber languages via
  `TranslatableEntityFilter`.

See the parent module `acquia_contenthub` doc `agent/extend/events.md` for the event catalog.
