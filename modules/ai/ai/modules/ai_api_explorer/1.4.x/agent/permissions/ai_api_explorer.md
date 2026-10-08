# permissions

From `ai_api_explorer.permissions.yml` — the module defines exactly **one** permission.

| Permission | Gates |
|---|---|
| `access ai prompt` | The AI API Explorer landing page (`/admin/config/ai/explorers`) and every per-explorer form route (`ai_api_explorer.form.<plugin_id>`). |

How it is enforced:

- The landing route `ai_api_explorer.list_page` requires `_permission: 'access ai prompt'`.
- Each dynamic explorer form route uses the `_ai_api_explorer_access` check
  (`Access\AiApiExplorerAccessChecker`), which allows access only when the plugin's
  `isActive()` is TRUE **and** its `hasAccess($account)` is TRUE. The base plugin's
  `hasAccess()` returns TRUE precisely when the account holds `access ai prompt`.

Treat it as a **trusted / development** permission: holders can pick any provider and model
and make real AI API calls, which spend credits. Grant it only to developers/site builders,
typically not on production.

```bash
drush role:perm:add developer 'access ai prompt'
```
