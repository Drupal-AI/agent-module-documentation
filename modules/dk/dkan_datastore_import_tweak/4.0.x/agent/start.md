<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN Datastore Import Tweak (dkan_datastore_import_tweak) — agent index

Small add-on for the DKAN open-data platform. It makes the CSV delimiter and quoting
character used by DKAN's datastore importer configurable (DKAN core hard-codes them),
and can extend the delimiter setting to DKAN's MySQL `LOAD DATA` importer via a submodule.

## Dependencies
- `dkan:dkan_datastore` (info.yml). Composer requires `drupal/dkan:^4`.
- Core `^10 || ^11`. No PHP libraries, no other Drupal module deps.
- Submodule additionally needs `dkan:dkan_datastore_mysql_import`.

## What it provides
- Settings form `Drupal\dkan_datastore_import_tweak\Form\ParserSettingsForm`
  at route `dkan_datastore_import_tweak.parser_settings`
  (path `/admin/dkan/parser-settings`, permission `administer site configuration`),
  linked under the DKAN admin menu (`dkan_datastore_import_tweak.links.menu.yml`).
- Config object `dkan_datastore_import_tweak.parser_settings` with keys
  `delimiter` and `quote` (schema in `config/schema/`).
- Event subscriber service `dkan_datastore_import_tweaks.parser_events_subscriber`
  (`src/EventSubscriber/ParserEventsSubscriber.php`) that listens on
  `ImportService::EVENT_CONFIGURE_PARSER` and writes `delimiter`/`quote` into the
  parser config before each datastore import.
- No permissions, entities, plugins, or Drush commands of its own.
  `.module` file is empty (no hooks).

## Submodule
- `dkan_datastore_mysql_import_tweak` — decorates `dkan.datastore.service.factory.import`
  to apply the configured `delimiter` to DKAN's MySQL `LOAD DATA` importer.
  Documented at `modules/dkan_datastore_mysql_import_tweak/4.0.x/`.

## Solution docs
- Configure the parser + how it wires into DKAN imports: `config/settings.md`
