# TacJS permissions

TacJS defines a single permission (`tacjs.permissions.yml`):

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer tacjs` | TRUE | All three config forms/routes: `tacjs.manage_dialog`, `tacjs.add_services`, `tacjs.edit_texts` (i.e. Manage dialog, Add services, Edit texts) |

It is flagged `restrict access: TRUE` (shown on the permissions page as a security-sensitive
permission) **because service and text definitions accept unfiltered text/JavaScript** — a user
with this permission can inject arbitrary script into every front-end page. Grant it only to
fully trusted administrators.

Grant with drush:

```bash
drush role:perm:add administrator 'administer tacjs'
```

The submodule `tacjs_log` reuses this same permission for its admin overview
(`/admin/config/system/tacjs/overview`); its public consent-logging endpoint is gated only by
`access content`.
