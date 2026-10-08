<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client Config Care (client_config_care) — agent index

**Tracks client-made config changes as revisionable “config blocker” entities and keeps them from being overwritten on config import via a Config Filter plugin.**

- **Version:** 2.0.x · **Core:** ^10 || ^11 · **Depends:** `config_filter` · **Configure:** `client_config_care.config_blocker_entity`
- **Entity:** `config_blocker_entity` (revisionable content entity; list/add/edit/delete/revision forms, `ConfigBlockerEntityController`).
- **Routes:** `client_config_care.config_blocker_entity` (→ entity view, perm *administer config blocker entity entities*), `entity.config_blocker_entity.revision_overview`.
- **Permissions:** add / administer (`restrict access`) / delete / edit / view published / view unpublished / view+revert+delete revisions of config blocker entities.
- **Filter plugin:** `IgnoreFilter` (`@ConfigFilter` id `client_config_care`) — ignores blocked config during read/exists/list/collection.
- **Subscribers:** `ConfigSave`, `ConfigDelete`, `ConfigImport` (record changes; `ArrayDiffer` computes diffs). **Deactivator** toggles protection (`SettingsFactory`).
- **Drush:** `client_config_care:generate_fixtures | show_all_blockers | delete_all_blockers | delete_config_blocker_by_name | is_activated`.
- **Security:** all routes/entity ops permission-gated (administer perm is `restrict access`); no anonymous or mutating public endpoints; no external HTTP.

See [drush/commands.md](drush/commands.md) and [configure/blockers.md](configure/blockers.md)
