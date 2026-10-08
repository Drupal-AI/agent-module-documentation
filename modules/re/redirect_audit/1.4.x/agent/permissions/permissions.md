# Permissions

Defined in `redirect_audit.permissions.yml`.

| Permission | Grants |
|-----------|--------|
| `administer redirect audit` | Full access: the dashboard route `redirect_audit.dashboard`, the settings route `redirect_audit.settings`, and every bulk operation (Audit scan, Fix, Clear) triggered from the dashboard. |

Both routes in `redirect_audit.routing.yml` require this single permission via
`_permission: 'administer redirect audit'`. There is no separate view/operate split — the
one permission covers reading the report and mutating redirects/config.

Notes:
- This is a distinct permission, **not** a reuse of the Redirect module's
  `administer redirects`. Auditing (including the Fix action, which rewrites `redirect`
  entities, and Clear, which truncates the audit tables) can therefore be delegated to an
  SEO/maintenance role without granting general redirect editing — and vice versa.
- Grant with `drush role:perm:add <role> 'administer redirect audit'`.
