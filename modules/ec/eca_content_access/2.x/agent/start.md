<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Content Access (eca_content_access) — agent index

Wires the **Content Access** module's per-node access grants into the **ECA** (Event–Condition–Action)
engine. It ships exactly **two ECA action plugins** — `eca_content_access_grant_access` and
`eca_content_access_revoke_access` — that add or remove one **role** for one **operation**
(view / update / delete, own or any) on a **single node**, then re-acquire and store that node's grant
records through core's node-access grant system. Everything runs inside an ECA model (trusted site
configuration, typically the BPMN modeller): the module has **no routes, controllers, forms, services,
hooks, permissions, Drush commands, or settings page** (`configure` = null). The only thing it ships
besides the two plugin classes is their config schema.

Both actions are core `#[Action(type: 'node')]` plugins additionally tagged `#[EcaAction]`, so they
appear in ECA's action list for models whose subject is a node. `RevokeAccess` extends `GrantAccess`
and overrides only how the per-operation role list is edited (append vs. `array_diff`). The write path
is content_access's own: after editing the per-node settings row it calls
`NodeAccessControlHandler::acquireGrants()` + `node.grant_storage->write()`, so grant realm/gid come
from content_access/core, not from custom SQL.

- Depends on: `eca:eca (^2 || ^3)`, `content_access:content_access (^2)`.
- Core: `^10.4 || ^11`. PHP: `>=8.1`. Package: `ECA`.
- Settings page: none. Permissions: none. Drush: none. Config schema: yes (action config only).
- Plugin types provided: **none of its own** — it plugs into core's `action` plugin type via ECA.

## What you'd do → where
- Grant or revoke per-node role access from an ECA model — action ids, config keys, `access()`
  preconditions, the full `execute()` write path, the `follow_up` quirk, and the content_access ^2
  storage caveat → [plugins/actions.md](plugins/actions.md)

## Key facts (real machine names)
- Action ids: `eca_content_access_grant_access`, `eca_content_access_revoke_access` (both `type: node`,
  `version_introduced: 1.0.0`).
- Classes: `Drupal\eca_content_access\Plugin\Action\GrantAccess`,
  `Drupal\eca_content_access\Plugin\Action\RevokeAccess` (extends `GrantAccess`).
- Config schema keys: `action.configuration.eca_content_access_grant_access`,
  `action.configuration.eca_content_access_revoke_access`
  (`config/schema/eca_content_access.schema.yml`).
- Config keys: `operation` (`view|view_own|update|update_own|delete|delete_own`), `role` (a role id),
  `follow_up` (`none|display_message|rebuild`), `clear_cache` (bool), `object` (token name holding the
  node — ECA base config).
- Services consumed: `config.factory` (`content_access.settings`), `database`, `node.grant_storage`,
  `entity_type.manager` (node access control handler).
- Data touched: the `content_access` DB table (per-node `settings` row), plus node grant records via
  `acquireGrants()` / `node.grant_storage`.
