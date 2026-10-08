<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: profiles and connectors

Two config entity types drive cmrf_core. Both use
`admin_permission = "administer site configuration"` and are managed under `/admin/config/cmrf`
(menu link "CiviMRF" under System → Configuration). The module ships no permissions of its own.

## Connection profile (`cmrf_profile`)
Holds how to reach one CiviCRM instance. Config prefix `cmrf_core.cmrf_profile.*`.
Fields (`src/Entity/CMRFProfile.php`, form `src/Form/CMRFProfileForm.php`):
- `url` — CiviCRM **APIv3** REST endpoint, e.g. `https://example.org/civicrm/ajax/rest` (required).
- `urlV4` — CiviCRM **APIv4** endpoint, e.g. `https://example.org/civicrm/ajax/api4` (required by the form).
- `site_key` — the CiviCRM site key (required).
- `api_key` — the CiviCRM API key of the API user (required).
- `cache_expire_days` — days after which the call log is purged for this profile (default 0 = keep DONE/cached logic only).
- `cache_clear_failed_api_calls` — newline list of `entity.action` whose `FAIL` rows are always purged.

All of these are in the entity's `config_export`, so **the site key and API key are written to
exported configuration in plaintext**. A `default` profile is installed by
`config/install/cmrf_core.cmrf_profile.default.yml` with placeholder `SITE_KEY` / `API_KEY` and
`https://example.org/...` URLs — change these before use.

### Managing profiles
- List: `/admin/config/cmrf/profiles` — Add: `/admin/config/cmrf/profiles/add`.
- One profile can back many connectors (e.g. reuse one CiviCRM for several calling modules).

## Connector (`cmrf_connector`)
Names a caller and binds it to a profile + transport. Config prefix `cmrf_core.cmrf_connector.*`.
Fields (`src/Entity/CMRFConnector.php`, form `src/Form/CMRFConnectorForm.php`):
- `type` — free text: the module initiating/using the connection.
- `profile` — machine id of the `cmrf_profile` to use (required for remote).
- `connectiontype` — `remote` (default) or `local`. The `local` option and a "Local/Remote" select
  only appear when the `civicrm` service is present; otherwise `connectiontype` is a hidden field
  defaulting to `remote` and a profile is required. Update hook `cmrf_core_update_8202` backfills
  empty types to `remote`.

`Core::getConnection()` instantiates `LocalConnection` (after `civicrm.initialize()`) for `local`,
else `RemoteConnection`.

### Managing connectors
- List: `/admin/config/cmrf/connectors` — Add: `/admin/config/cmrf/connectors/add`.
- **Test**: each connector row has a "Test" operation → route `entity.cmrf_connector.test`
  (`/admin/config/cmrf/connectors/manage/{id}/test`, `administer site configuration`). It runs
  `Entity.get` through the connector and dumps the reply (`src/Controller/CMRFConnectorTester.php`)
  — a quick config check.

## Programmatic registration
`Core::registerConnector($name, $profile)` / `unregisterConnector($id)` create/delete connector
entities from code (used by submodules). `getConnectors()`, `getConnectionProfiles()`,
`getDefaultProfile()` enumerate what's configured; the default profile is the one with id `default`.
