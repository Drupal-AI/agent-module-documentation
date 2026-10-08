<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Drush/Commands/EntityChangeDefaultLanguageCommands.php`. Both commands validate the
entity type (must exist and be translatable) and the langcode (must exist) before acting, and prompt for
confirmation (default No).

## `ecdl:cdl` — change one entity
`entity_change_default_language:change-default-language <entity_type_id> <entity_id> <default_langcode>`

- Loads the entity (must exist and be translatable), errors if it is already in the target language,
  confirms, then calls the service `update()`.
- Options:
  - `--preserve-legacy-default-language` (default TRUE) → passed as the `$create` flag to `update()`
    (keeps the legacy default as a translation).
  - `--preserve-languages` → comma-separated list of translation langcodes to keep (becomes
    `$langcodes`).
- Example: `drush ecdl:cdl node 1 en --preserve-languages=en`

## `ecdl:dlet` — change a whole entity type
`entity_change_default_language:change-default-language-entity-type <entity_type_id> <default_langcode>`

- Queries all entities of the type whose `langcode != $default_langcode` (query uses
  `accessCheck(FALSE)` — CLI/admin context), optionally filtered by `--bundle`, logs the count,
  confirms, then **enqueues** one item per entity onto the `entity_change_default_language` queue.
  It does not process them inline.
- Options: `--bundle`, `--preserve-legacy-default-language` (default TRUE), `--preserve-languages`.
- Example: `drush ecdl:dlet node en --preserve-languages=en`
- Aliases: `ecdl:dlet`.

## Queue worker
`Plugin/QueueWorker/EntityChangeDefaultLanguage` (id `entity_change_default_language`, cron time 60s).
`processItem()` loads the queued entity and, only if it **has** a translation in the target langcode and
its current default differs, calls the service `update()` with the item's
`preserve_legacy_default_language` / `preserve_languages`. Run via cron or
`drush queue:run entity_change_default_language`.
