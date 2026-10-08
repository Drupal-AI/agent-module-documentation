# scanner — permissions

Defined in `scanner.permissions.yml`. Three permissions gate the routes in
`scanner.routing.yml`:

| Permission | Restricted | Gates | Notes |
|---|---|---|---|
| `perform search only` | yes | `scanner.admin_content` (search tool) | Search but **not** replace. |
| `perform search and replace` | yes | `scanner.admin_content`, `scanner.admin_confirm`, `scanner.undo`, `scanner.undo_confirm` | Full search + replace + undo. **Bypasses normal entity edit access** — a holder can rewrite fields even without edit permission on the entity. |
| `administer scanner settings` | yes | `scanner.admin_config` (settings form) | Configure default options and which fields are scannable. |

The tool route `scanner.admin_content` requires `perform search only+perform search and
replace` (the `+` means **either** permission grants access to reach the form; only the
replace/confirm steps require `perform search and replace`).

Grant via Drush:

```bash
drush role:perm:add editor 'perform search and replace'
drush role:perm:add auditor 'perform search only'
```
