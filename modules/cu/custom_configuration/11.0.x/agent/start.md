<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Configuration (custom_configuration) — agent index

Stores an unlimited number of named values in a **custom SQL table** (`custom_configuration`),
each keyed by **machine name + domain + language**, and reads them back through the
`custom.configuration` service. Package `custom`. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 11.0.0. No hard dependencies; contrib **Domain** is optional (enables
per-domain values). Not core Config API — values live in a DB table, not config objects.

- **Admin UI, routes, the DB schema, add/edit/delete forms** →
  [config/admin-ui.md](config/admin-ui.md)
- **Reading values in code: the `custom.configuration` service (`getValue`/`getValues`)** →
  [api/service.md](api/service.md)

## What it actually is

- One service, `custom.configuration` → `Helper\ConfigurationHelper`
  (`src/Helper/ConfigurationHelper.php`), holding all CRUD + read logic. Injected args:
  `@database`, `@module_handler`, `@language_manager`, `@service_container`.
- One database table `custom_configuration` created by `custom_configuration_schema()`
  (`custom_configuration.install`); columns include `custom_config_machine_name`,
  `custom_config_value`, `custom_config_options` (serialized), `custom_config_domains`,
  `custom_config_langcode`, `custom_config_status`. Unique key on
  (machine_name, domains, langcode). `hook_update_8319()` back-fills the options/domain/langcode
  columns on older installs.
- Four routes, all `_permission: 'administer site configuration'`
  (`custom_configuration.routing.yml`): add (`ConfigurationForm`), list
  (`CustomConfigurationList`), edit (`EditConfigurationForm`), delete
  (`DeleteConfigurationForm`) — all under `/admin/config/system/custom_config…`.
- No permissions of its own, no Drush, no plugins, no config schema, no config/install. Only
  `hook_help()` in `custom_configuration.module`. Menu link + local tasks under
  *Configuration → System*.

## Mechanism (from source)

- **Write**: `ConfigurationHelper::createConfiguration()` / `updateValue()` insert/update rows via
  the database query builder; the four optional textareas are `serialize()`d into
  `custom_config_options`; domains/languages are stored as comma-wrapped strings
  (`,en,` / `,default,`) built by `implodeLanguage()` / `implodeDomains()`.
- **Read**: `getValue($machine_name, $langCode = NULL, $domainKey = NULL)` returns the single
  string value; `getValues(...)` returns a stdClass with `value`, `optional` (unserialized with
  `allowed_classes => FALSE`), `name`, `langcode[]`, `domain_key[]`. Both filter on
  `custom_config_status = 1` (Active) and match language/domain with a `LIKE '%,key,%'` condition;
  missing → `NULL`.
- **Context**: when langcode/domain are omitted, `getActiveLanguage()` uses
  `language_manager->getCurrentLanguage()`; `getActiveDomain()` returns `'default'` unless the
  **Domain** module is enabled, then `domain.negotiator->getActiveDomain()->id()`.

## Notes / caveats

- Queries use the parameterized query builder (`select`/`insert`/`update`/`condition`), and
  `custom_config_options` is unserialized with `['allowed_classes' => FALSE]`.
- All add/edit/delete/list routes are behind `administer site configuration`.
- Stored entries are ordinary DB rows, not encrypted secrets — treat like config, not a vault.
- `getConfigList()` has a stray leading tab in one selected field name
  (`'\tcustom_config_options'`), so that column is effectively not selected there; `getValues()`
  reads options via its own path, so runtime reads are unaffected.
