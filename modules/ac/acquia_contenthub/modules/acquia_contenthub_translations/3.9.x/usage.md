Experimental Content Hub submodule that gives subscriber sites control over which languages of a
syndicated entity are imported, so a delivery site keeps only the languages it actually serves and
prunes the rest from incoming content.

---

By default Content Hub imports every translation of an entity. This submodule tracks each entity's
translations locally in two dedicated tables (`acquia_contenthub_entity_translations_tracking` and
`acquia_contenthub_entity_translations`, kept in sync by `hook_entity_*` implementations and a
translation facilitator/manager), and on import prunes undesired languages from the incoming CDF so
only the languages a site wants are created or updated. It adds a settings form at
`/admin/config/services/acquia-contenthub/translations` (`ContentHubTranslationsSettingsForm`,
gated by the base module's Content Hub UI access) with a master `selective_language_import` toggle
and an `override_translation` toggle, backed by config `acquia_contenthub_translations.settings`.
The pruning and filtering run through base-module event subscribers (`PruneLanguagesFromCdf` on
`PRUNE_CDF`, `DeleteUndesiredTranslations` and `TrackTranslations` on `PARSE_CDF`,
`NormalizeFieldValues` on `ENTITY_DATA_TAMPER`) and service decorators over the subscriber's
webhook import handlers and `entity_upsert` queue action, all filtering by the site's languages via
`TranslatableEntityFilter`. A `nt_entity_handler` tagged-service extension point classifies
non-translatable entities (file, redirect, path_alias, …) so mixed translatable/non-translatable
dependency graphs import cleanly. It requires `acquia_contenthub` and `acquia_contenthub_subscriber`
and is experimental; after enabling, the publisher must re-export so CDF metadata carries the
`translatable` attribute.

---

- Import only the languages a subscriber site actually serves.
- Drop unwanted translations from incoming syndicated content.
- Keep a delivery site lean by excluding irrelevant languages.
- Toggle selective language import from the translations settings form.
- Allow or forbid overwriting locally modified translations on import.
- Track entity translations locally for correct pruning decisions.
- Prevent creation of translations a site did not request.
- Delete undesired translations that arrive via CDF.
- Normalize field values across languages during import.
- Handle webhooks and queue upserts carrying translatable assets selectively.
- Classify non-translatable entities (file/redirect/path_alias) via handlers so mixed graphs import cleanly.
- Register a custom non-translatable entity handler through the `nt_entity_handler` service tag.
- Mark languages "undesired" so they are excluded from syndication where possible.
- Support region-specific sites that need a subset of a global content pool.
- Reduce storage and cache overhead from unused translations.
- Maintain per-site language policies across a multi-site fleet.
- Combine with the subscriber import queue for language-aware syndication.
- Keep translation syndication under editorial/governance control.
- Avoid importing languages that have no configured language on the site.
