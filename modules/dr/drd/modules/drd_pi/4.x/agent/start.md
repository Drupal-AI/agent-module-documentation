<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Platform Integration (drd_pi) — agent index

Abstract framework submodule of **DRD (Drupal Remote Dashboard)**. It does **not** define a
Drupal plugin type; it provides reusable **abstract PHP classes** that platform-specific
submodules extend to import a hosting platform's inventory (hosts, cores, domains) into DRD.
Package `DRD`. Depends on **`drd`**. Core `^10 || ^11`. Version dir 4.x (release 4.1.7).
No permissions of its own; no config schema; no configuration route.

- **The framework classes, sync algorithm, action, Drush command, block and base fields** →
  [api/framework.md](api/framework.md)

## What it actually is (from source)

- **Abstract account base**: `DrdPiAccount` (`src/DrdPiAccount.php`) extends core
  `ConfigEntityBase`, implements `DrdPiAccountInterface` + `drd`'s `EncryptionEntityInterface`.
  Holds the platform sync algorithm (`sync()`, `syncEntities()`), credential encrypt/decrypt
  helpers (`getDecrypted()`, `setEncrypted()` via the `drd.encrypt` service), and a `shell()`
  helper (mikehaertl `ShellCommand`). Provider submodules subclass it and implement
  `getPlatformHosts()` / `getPlatformCores()` / `getPlatformDomains()`.
- **Inventory value objects**: abstract `DrdPiEntity` + interface, and concrete `DrdPiHost`,
  `DrdPiCore`, `DrdPiDomain`. Each `create()` builds and saves the matching DRD entity
  (`drd\Entity\Host|Core|Domain`); `DrdPiDomain::determineUrl()` probes https then http with a
  HEAD request to find the reachable URL; `DrdPiEntity::update()` syncs an `Authorization`
  header into the DRD domain's `header` (key_value_field) field.
- **Shared UI**: `DrdPiAccountForm` (add/edit form: enabled, label, machine name) and
  `DrdPiAccountListBuilder` (account collection table).
- **Base fields** (`drd_pi.module`, `hook_entity_base_field_info`): read-only string fields
  `pi_id_domain` (on `drd_domain`), `pi_id_core` (`drd_core`+`drd_domain`), `pi_type`,
  `pi_account`, `pi_id_host` (on `drd_host`+`drd_core`+`drd_domain`). Helper
  `drd_pi_get_entity_value()`.
- **DRD action**: `Sync` (`src/Plugin/Action/Sync.php`, id `drd_action_pi_sync`, extends
  `drd\Plugin\Action\BaseGlobal`) loads every enabled account whose class implements
  `DrdPiAccount` and calls `->sync()`. Shipped as optional config
  `system.action.drd_action_pi_sync`.
- **Drush**: `DrdPiCommands` (`src/Drush/Commands/`) — command `drd:pi:sync`
  (alias `drd-pi-sync`) runs the `drd_action_pi_sync` action.
- **Block**: `WidgetPlatforms` (id `drd_pi_platforms`, tag `drd_widget`), access =
  `drd.administer` permission; provider blocks subclass it for per-platform entity counts.

## Sync model

`DrdPiAccount::sync()` → for each remote host: `syncEntities()` reconciles by `pi_*` fields —
creates DRD entities that are new, updates existing ones, and toggles `setPublished()` so
entities missing from the platform get unpublished and reappearing ones re-enabled. Then per
host it fetches cores, and per core domains, recursing the same reconcile.

## Notes

- Credential fields declared by a subclass's `getEncryptedFieldNames()` are encrypted at rest
  through DRD's `drd.encrypt` service (encrypt module profile). If no profile is configured DRD
  surfaces an admin error and values are stored unencrypted — configure an encryption profile.
- All remote HTTP is via `http_client_factory` (Guzzle) with default TLS verification.
