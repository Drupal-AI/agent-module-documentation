# permissions — what AI Automators defines

From `ai_automators.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer ai_automator` | Configuring automators: the AI Automators area (`/admin/config/ai/ai-automators`), the `ai_automator` collection/add/edit/delete forms, and the automator section on field config forms. Also the `ai_automator` entity's `admin_permission`. |
| `administer automators_tool` | Create/edit/delete `automators_tool` entities (`/admin/config/ai/ai-automators/automators-tool`) and the workflow autocomplete route. |
| `administer automator_chain types` | Manage `automator_chain_type` bundles. Marked `restrict access: true` — grant only to trusted roles. |

Grant with drush:
```bash
drush role:perm:add administrator 'administer ai_automator'
```

Note: because automators trigger AI provider calls (which cost money and can expose content to
a vendor), treat `administer ai_automator` as security-sensitive. Field UI must be enabled to
add/alter automators; it can be uninstalled afterwards without removing existing automators.
