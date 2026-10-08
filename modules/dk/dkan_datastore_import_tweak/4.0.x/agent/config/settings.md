<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the DKAN datastore CSV parser

## Install / enable
- Requires a working DKAN 4.x site with `dkan_datastore` enabled (it is not
  auto-enabled — enable it first). `composer require drupal/dkan_datastore_import_tweak`,
  then `drush en dkan_datastore_import_tweak`.
- Optional: enable `dkan_datastore_mysql_import_tweak` too if the site uses the
  MySQL `LOAD DATA` importer (`dkan_datastore_mysql_import`). See the submodule doc.

## Settings form
- Route: `dkan_datastore_import_tweak.parser_settings`, path `/admin/dkan/parser-settings`,
  permission `administer site configuration` (`dkan_datastore_import_tweak.routing.yml`).
  Menu link under the DKAN admin section (`links.menu.yml`, parent `system.admin_dkan`).
- Form class `Drupal\dkan_datastore_import_tweak\Form\ParserSettingsForm` (a
  `ConfigFormBase`, editable config `dkan_datastore_import_tweak.parser_settings`,
  constant `ParserSettingsForm::CONFIG_NAME`).
- Two `select` fields:
  - `delimiter` — options `,`, `;`, whitespace (`' '`). Default `,`.
  - `quote` — options `"`, `'`. Default `"`.
  - `submitForm()` saves both into the config object; `validateForm()` is a no-op.

## Config object & schema
- Object: `dkan_datastore_import_tweak.parser_settings`.
- Schema `config/schema/dkan_datastore_import_tweak.schema.yml`: `config_object`
  with string mappings `delimiter` and `quote`.
- Managed by standard Drupal config; export/import with your config workflow.

## How it reaches the importer
- `ParserEventsSubscriber` (service `dkan_datastore_import_tweaks.parser_events_subscriber`,
  arg `@config.factory`) subscribes to `ImportService::EVENT_CONFIGURE_PARSER`
  (`Drupal\dkan_datastore\Service\ImportService`).
- On that event, `configureParser(Event $event)` reads the current
  `$event->getData()` parser config, overwrites `delimiter` and `quote` with the
  configured values, and calls `$event->setData(...)`. This runs for every
  datastore CSV import, so the setting is site-wide, not per-dataset.
- Because the subscriber reads config at construction (`$config_factory->get(...)`),
  a container rebuild / cache clear is picked up on the next request; changing the
  values then re-running an import applies them.

## Operating notes
- Values are chosen from fixed select lists (no free text), so only the four
  offered delimiter/quote combinations can be stored through the UI.
- The standard datastore importer applies both `delimiter` and `quote`. The MySQL
  submodule importer applies only `delimiter` (and always uses a literal tab for
  `text/tab-separated-values` resources) — see the submodule doc.
- No revert/uninstall config cleanup hooks; the config object is removed on
  standard module uninstall.
