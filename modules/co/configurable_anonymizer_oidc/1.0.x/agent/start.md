<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configurable Anonymizer OIDC — agent start

info.yml name **Configurable Anonymizer OIDC** (`configurable_anonymizer_oidc`), version **1.0.0**,
core `^10 || ^11`, package Custom. Add-on that lets you **exempt users of chosen OIDC realms from
anonymization** when the parent [Configurable Anonymizer](https://www.drupal.org/project/configurable_anonymizer)
runs (`drush anonymizer:run`). Depends on `configurable_anonymizer:configurable_anonymizer` and `oidc:oidc`.

## Mechanism (source)

- **Settings form** `Drupal\configurable_anonymizer_oidc\Form\SettingsForm` at
  `/admin/config/development/anonymizer/oidc` (route `configurable_anonymizer_oidc.settings`,
  also a tab/menu-link under the parent `configurable_anonymizer.settings`). A `checkboxes`
  element **Disabled realms** lists every OIDC realm plugin (`plugin.manager.openid_connect_realm`
  → `getAll()` / `getDefinition()['name']`) and stores the chosen plugin IDs.
- **Config** `configurable_anonymizer_oidc.settings:disabled_realms` — a `sequence` of
  `openid_connect_realm` plugin IDs (schema `config/schema/configurable_anonymizer_oidc.schema.yml`).
- **Query alter** `Drupal\configurable_anonymizer_oidc\Hook\QueryAlter` implements
  `#[Hook('query_configurable_anonymizer_alter')]`. On the parent's tagged `user` select
  (checks `getMetaData('entity_type') === 'user'`) it `leftJoin`s `authmap` on `uid` and adds
  `authmap.provider NOT IN ('oidc:'.$realm, …)` for each disabled realm — so those users are
  dropped from the set the anonymizer processes. No effect if `disabled_realms` is empty.

The realm→user link is Drupal's core `authmap` table (`provider` = `oidc:<realm>`), written by the
`oidc` module at login; this module only reads it. It performs no OIDC network calls, stores no
client secret, and holds no credentials of its own.

## Access & surface

- **Permission** `administer configurable anonymizer oidc settings` gates the settings route
  (`configurable_anonymizer_oidc.permissions.yml`). No other routes, controllers, or services.
- No Drush commands of its own (the run command `anonymizer:run` belongs to the parent module).

## Files

- `configurable_anonymizer_oidc.info.yml`, `.routing.yml`, `.permissions.yml`, `.links.menu.yml`, `.links.task.yml`
- `src/Form/SettingsForm.php` — realm-selection config form
- `src/Hook/QueryAlter.php` — the `query_configurable_anonymizer_alter` implementation
- `config/schema/configurable_anonymizer_oidc.schema.yml` — `disabled_realms` schema
- Prose: [../usage.md](../usage.md) · human guide [../human-docs/index.md](../human-docs/index.md)

Data-handling note: exempting a realm **retains those users' real field values** while other users'
configured fields are anonymized — set exemptions only where retaining that data is intended and
compliant.
