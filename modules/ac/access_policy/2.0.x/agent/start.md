<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Policy (access_policy) — agent index

Attribute-Based Access Control (ABAC) for Drupal content entities: an admin defines reusable
**access rules** and **selection rules** and assembles them into named **access policy** config
entities; each policy is assigned to entities (manually via an **Access** tab, or dynamically via
selection rules) and then restricts `view`/`update`/`delete`/revision/unpublished access. No code
required. Complements core RBAC; leverages entity fields as the attributes.

- Core: `^10.3 || ^11`. No other module dependencies.
- Base module has **no settings page** (`configure: null`). The admin UI lives in the
  **`access_policy_ui`** submodule (ships in this tarball; enable it to create policies —
  `configure: entity.access_policy.collection` at `/admin/people/access-policies`).
- Defines permissions (static + generated per-policy), one Drush command, config schema, and
  eight plugin types. Adds an `access_policy` entity-reference base field to every access-controlled
  entity type.

Solution docs:
- **Create/configure policies, selection strategy, config structure** → [configure/settings.md](configure/settings.md)
- **Static + per-policy generated permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Diagnose why a user can/can't access an entity** → [drush/commands.md](drush/commands.md)
- **Register fields as access rules; alter rule data** → [hooks/hooks.md](hooks/hooks.md)
- **The eight plugin types + adding a custom access rule** → [plugins/plugins.md](plugins/plugins.md)
- **Public services (validator, selection, information, etc.)** → [api/services.md](api/services.md)

Key facts:
- Config entity: `access_policy` (prefix `access_policy.access_policy.*`, `admin_permission = administer access policy entities`).
- Settings config object: `access_policy.settings` → `entity_type_settings.<type>.selection_strategy` (`dynamic`|`manual`), `selection_strategy_settings`, `selection_sets`.
- Base field added to controlled entities: `access_policy` (entity_reference → `access_policy`).
- Static permissions: `administer access policy entities` (restrict access), `set entity access policy`.
- Generated per-policy permissions (via `AccessPolicyPermissions::entityPermissions`, a `permission_callbacks` entry): `view/edit/delete <id> <type>`, `view any <id> unpublished <type>`, `view all <id> <type> revisions`, `assign <id> access policy`, `bypass <id> access rules`, `edit <id> user information`.
- Services: `access_policy.validator`, `access_policy.selection`, `access_policy.information`, `access_policy.content_policy_manager`, `access_policy.discovery`, `access_policy.entity_type_settings`.
- Plugin managers: `plugin.manager.access_policy.access_rule`, `plugin.manager.access_policy.selection_rule`, `plugin.manager.selection_strategy`, `plugin.manager.access_policy_operation`, `plugin.manager.access_policy_query`, `plugin.manager.access_rule_argument`, `plugin.manager.access_rule_widget`, `plugin.manager.http_403_response`.
- Hooks provided: `hook_access_policy_data`, `hook_access_policy_data_alter`.
- Drush: `access-policy:check-access <entity_type> <id> <username>` (alias `apca`).
- Route: `access_policy.403` → `/access_policy/403/{access_policy}` (renders the policy's configured access-denied message).
- Release documented: `2.0.0-rc1` (no stable 2.0.x release exists yet).
