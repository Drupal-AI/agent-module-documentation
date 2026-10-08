<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drd_pi framework API

How to build a platform integration on top of `drd_pi`, and what the base classes do.

## Install / enable

`drush en drd_pi` (pulls in `drd`). You normally do not enable it directly — enabling
`drd_pi_acquia`, `drd_pi_pantheon` or `drd_pi_platformsh` enables it as a dependency. There is
no settings form; configuration happens in the provider submodules' account entities.

## Building a provider (extend `DrdPiAccount`)

Create a config entity class extending `Drupal\drd_pi\DrdPiAccount` and implement
`DrdPiAccountInterface`. Required methods (see `src/DrdPiAccountInterface.php`):

- `getModuleName()` / `getConfigName()` — static; config name is `<module>.settings`.
- `getPlatformName()` — human label used in logs and widgets.
- `getPlatformHosts(): DrdPiHost[]` — fetch the platform's sites.
- `getPlatformCores(DrdPiHost): DrdPiCore[]` — fetch environments/cores for a host (and attach
  a `DrdPiDomain` to each core).
- `getPlatformDomains(DrdPiCore): DrdPiDomain[]` — base class returns the domains already
  attached to the core during `getPlatformCores()`.
- `getAuthorizationMethod(): string` and `getAuthorizationSecrets(DrdPiDomain): array` — the
  `drd_agent` auth method constant and the secrets DRD uses to authorize itself remotely.
- `getEncryptedFieldNames(): array` (from `EncryptionEntityInterface`) — config keys to encrypt.

Declare the entity with a `@ConfigEntityType` annotation whose `list_builder` is
`Drupal\drd_pi\DrdPiAccountListBuilder`, whose add/edit form extends `DrdPiAccountForm`, and
whose `admin_permission` is `administer site configuration`.

### Credential storage

`DrdPiAccount::setEncrypted($key, $value)` calls `\Drupal::service('drd.encrypt')->encrypt()`
(the value is passed **by reference** and replaced in place) before `set()`, and
`getDecrypted($key)` decrypts on read. Encryption uses the encrypt-module profile named in
`drd.general.encryption_profile`; configure one under DRD settings.

## Inventory value objects

- `DrdPiEntity` (abstract, `id()`, `label()`, `setDrdEntity()`, `hasDrdEntity()`,
  `setHeader()`, `update()`): `update()` writes an `Authorization` key into the DRD entity's
  `header` (key_value_field) list, adding/updating/removing it to match `$this->header`.
- `DrdPiHost::create()` → `drd\Entity\Host::create([...pi_* ...])->save()`.
- `DrdPiCore::create()` → `drd\Entity\Core::create([...])`; holds attached domains
  (`addDomain()`, `getDomains()`) and its host (`setHost()`, `host()`).
- `DrdPiDomain`: `setDetails(core, domainname)`; `determineUrl(secure=TRUE)` issues a Guzzle
  HEAD to `https://<domain>` (falling back to `http://`) using any set `Authorization` header,
  returns the first URL that answers `< 300` or FALSE; `create()` builds the DRD domain via
  `Domain::instanceFromUrl()`, then `authorizeBySecret()` + `initCore()`/`remoteInfo()`.

## Sync algorithm (`DrdPiAccount`)

`sync()` logs, then: `getPlatformHosts()` → `syncEntities($hosts, 'host')`; for each host
`getPlatformCores()` → `syncEntities($cores, 'core', $host)`; for each core
`getPlatformDomains()` → `syncEntities($domains, 'domain', $core)`.

`syncEntities($platform, $type, $parent)`:
1. Loads existing DRD entities of `drd_<type>` filtered by `pi_type`/`pi_account` (+ parent
   `pi_id_host`/`pi_id_core`).
2. Matches each platform entity to an existing one via `drd_pi_get_entity_value()`; unmatched
   ones get `->create()`; all matched/created get `->update()`.
3. Any existing DRD entity not present on the platform is `setPublished(FALSE)`; reappearing
   ones are re-enabled — keeping DRD's published state in step with the platform.

## Running a sync

- Action: `drd_action_pi_sync` (`Sync::executeAction()` loops every enabled `DrdPiAccount`
  subclass instance across all registered platform types and calls `->sync()`).
- Drush: `drush drd:pi:sync` (alias `drd-pi-sync`), `DrdPiCommands::sync()`.
- Dashboard: the `drd_pi_platforms` block (`WidgetPlatforms`, access `drd.administer`).

## Base fields (drd_pi.module)

`hook_entity_base_field_info()` adds read-only strings so each imported DRD entity records its
origin: `drd_host` gets `pi_type`, `pi_account`, `pi_id_host`; `drd_core` also gets
`pi_id_core`; `drd_domain` also gets `pi_id_domain`. Read them with
`drd_pi_get_entity_value($entity, $type)`.
