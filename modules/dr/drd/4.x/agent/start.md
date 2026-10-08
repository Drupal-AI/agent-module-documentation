<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Remote Dashboard (drd) — agent index

A central **control plane** for managing a fleet of remote Drupal sites. DRD (the "dashboard")
inventories remote sites and drives administrative operations on them over an encrypted HTTP
channel; each managed site runs the companion **`drd_agent`** module that receives and executes
those commands. Package `DRD`. Core `^10 || ^11`, PHP `>=8.1`, license GPL-2.0-or-later.
Version dir 4.x (installed 4.1.7).

## Dependencies

Hard: `advancedqueue`, `drd_agent`, core `taxonomy`, `update`, `views`, `encrypt`, `eva`
(Entity Views Attachment), `key_value_field`. Composer libraries include `phpseclib/phpseclib`,
`albertofem/rsync-lib`, `mikehaertl/php-shellcommand`, `cypresslab/gitelephant`,
`platformsh/client`. Recommends `extlink`, `hacked`, `monitoring`, `real_aes`, `security_review`.

## What it provides (from source)

- **Content entities** (`src/Entity/*`): `drd_host`, `drd_core`, `drd_domain`, `drd_project`,
  `drd_major`, `drd_release`, `drd_requirement`; **config entities** `drd_script`,
  `drd_script_type`. See [entities/entities.md](entities/entities.md).
- **Remote action RPC framework**: `Plugin/Action/*` (Base → BaseEntity → BaseEntityRemote →
  BaseCoreRemote / BaseHost / BaseGlobal), `ActionManager`, `QueueManager`, and the outbound
  `HttpRequest` transport. Concrete actions: `drd_action_php`, `drd_action_update`,
  `drd_action_database`, `drd_action_flush_cache`, `drd_action_cron`, `drd_action_maintenance_mode`,
  `drd_action_info`, `drd_action_ping`, `drd_action_session`, `drd_action_domains_receive`, etc.
  See [api/remote-actions.md](api/remote-actions.md).
- **Credential encryption / crypto stack**: `Encryption` service (`drd.encrypt`, uses the Encrypt
  module) for at-rest secrets; `Crypt/*` (OpenSsl / Mcrypt / Tls) for the per-domain transport
  payload; `Plugin/Auth/*` (`shared_secret`, `username_password`) for authenticating to the agent.
  See [api/crypto-and-auth.md](api/crypto-and-auth.md).
- **Update pipeline plugin types** (`Plugin/Update/*`, `Update/Manager*`): Build, Process, Test,
  Deploy, Finish, Storage — orchestrated by `Update/Manager`.
- **Plugin types**: DRD Action (`plugin.manager.drd_action`), DRD Auth (`plugin.manager.drd_auth`),
  DRD Update build/process/test/deploy/finish/storage.
- **Field formatters** `IPv4`, `IPv6`, `Secure`; **Blocks** (`Plugin/Block/Widget*`, remote block
  derivative); **Views** field/filter handlers; **ContextProviders** for host/core/domain.
- **Permissions**: static in `drd.permissions.yml` plus dynamic per-action permissions from
  `ActionPermissions::permissions`. **Drush**: `src/Drush/Commands/DrdCommands.php` + an action-plugin
  generator. See [config/routes-permissions.md](config/routes-permissions.md).
- **Config & settings**: `drd.general` config object, settings form at `/drd/settings`, config
  schema under `config/schema/`, default entities/views/actions under `config/optional/`.
  See [config/settings.md](config/settings.md).

## Submodules (documented separately)

`drd_eca` (ECA events), `drd_install_core` (provision sites via webform), `drd_migrate` (import a
DRD 7 inventory); plus `drd_pi`, `drd_pi_acquia`, `drd_pi_pantheon`, `drd_pi_platformsh` (hosting
providers — documented elsewhere).

## Key routes

Dashboard `/drd` (`drd.access`); settings `/drd/settings` (`drd.administer`); entity collections
`/drd/hosts`, `/drd/cores`, `/drd/domains`, `/drd/projects`, `/drd/majors`, `/drd/releases`,
`/drd/requirements`; scripts `/drd/settings/scripts`. All routes are permission-gated; DRD exposes
no public/anonymous endpoint (the inbound endpoint lives in `drd_agent`, not here).
