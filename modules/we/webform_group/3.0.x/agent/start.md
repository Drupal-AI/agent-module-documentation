# Webform Group — agent index

Adds **group-role**-based access to webforms placed on group nodes (Webform + Group/gnode), plus
group-role email tokens. No own permissions; composes Webform's access rules and Group's roles.
Provides a config schema, a `webform_group_roles` form element, and `webform_group` tokens.

- **Group-role access rules** — the Access settings UI, the four access hooks, submission query
  access, per-element access → [configure/access.md](configure/access.md)
- **Email integration** — group-role recipient tokens, the site-wide allowlist on the email
  handler settings form, `webform_group.settings` → [configure/email.md](configure/email.md)
- **`WebformGroupManager` service** — group-relationship / group-role lookup API →
  [api/manager.md](api/manager.md)

Submodule (own docs):
- `webform_demo_group` (example group types + demo webform) →
  [../../modules/webform_demo_group/3.0.x/agent/start.md](../../modules/webform_demo_group/3.0.x/agent/start.md)

Key facts:
- Config: `webform_group.settings` → `mail.group_owner` (bool), `mail.group_roles` (allowlist).
- Access is stored on each webform's own `access` config under a per-rule `group_roles` sequence
  (schema added via `hook_config_schema_info_alter`).
- Service: `webform_group.manager` (`\Drupal\webform_group\WebformGroupManager`).
- Only applies when the webform's source entity is a group-related node (via `gnode`).
