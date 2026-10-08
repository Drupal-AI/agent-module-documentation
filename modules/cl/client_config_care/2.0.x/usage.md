<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Client Config Care protects configuration a client changed on the live site from being silently overwritten by a `drush config:import` deployment, by tracking such config as “config blocker” entities and excluding them from import via a Config Filter plugin.

Config event subscribers (`ConfigSave`, `ConfigDelete`, `ConfigImport`) watch config changes; an `ArrayDiffer` computes what actually changed, and changes are recorded as revisionable `config_blocker_entity` content entities. The `IgnoreFilter` Config Filter plugin (id `client_config_care`) then reads the active blockers and makes the ignored config “stick” during import/export — similar to `config_ignore`, but driven by tracked, per-item blocker entities that carry a log of who changed what. A `Deactivator` (backed by `SettingsFactory`) can globally switch the protection on/off. Drush commands generate, list, and delete blockers and report activation state.

Typical setup: enable the module (requires `config_filter`), let it record client changes as blockers, review them at Structure → Config blocker entities, and run your normal config import knowing blocked items are preserved.

---

Short summary: track client config changes as blocker entities and keep them from being overwritten on config import.

It solves the deployment hazard where a client tweaks config in production and the next `config:import` reverts it. It works by recording changes as revisioned blocker entities and applying a Config Filter that ignores those keys during import/export, with a full audit log of the changes.

Operationally: entity management is gated behind the *administer / add / edit / delete / view config blocker entity* permissions (the administer permission is marked `restrict access`). Protection can be toggled via the Deactivator/settings. Drush commands: `client_config_care:generate_fixtures`, `:show_all_blockers`, `:delete_all_blockers`, `:delete_config_blocker_by_name`, `:is_activated`.

---

- Prevent a client's live config change from being overwritten on import.
- Track which config items clients have changed.
- Record config changes as revisionable blocker entities.
- Keep an audit log of who changed which config.
- Exclude blocked config from `drush config:import`.
- Exclude blocked config from config export too (via the filter).
- Review tracked config blockers in the admin UI.
- Add a config blocker entity manually.
- Delete config blockers that are no longer needed.
- View revisions of a config blocker entity.
- Globally deactivate protection when doing a full re-import.
- Reactivate protection after a deployment.
- List all current blockers with a Drush command.
- Delete all blockers in one Drush command.
- Delete a specific blocker by config name via Drush.
- Check whether protection is currently active via Drush.
- Generate fixture blockers for testing via Drush.
- Restrict blocker administration with dedicated permissions.
- Combine with a standard config-deployment workflow safely.
- Diff actual config changes with the built-in ArrayDiffer.
- Protect a subset of config while still deploying everything else.
