# Permissions

Defined in `view_unpublished.permissions.yml` (static `view any unpublished content`)
plus a dynamic permission callback `ViewUnpublishedPermissions::permissions()` that
emits one permission per node type (via `BundlePermissionHandlerTrait`).

| Permission | Gates |
|---|---|
| `view any unpublished content` | View **all** unpublished nodes of every content type (read-only). |
| `view any unpublished <type> content` | View unpublished nodes of a single content type, e.g. `view any unpublished article content`. One is generated per node type. |

Core's `view own unpublished content` (from node module) still lets users see only
their own drafts; this module adds the "any" grants on top.

How it works: the module implements `hook_node_access_records()` and
`hook_node_grants()`. Unpublished nodes are recorded in the `view_unpublished_content`
and per-type `view_unpublished_<type>_content` realms (plus a per-owner
`view_unpublished_author` realm for the "own" case); a user holding the matching
permission receives that grant. Records are written per translation language. Read
access only — `grant_update`/`grant_delete` are 0.

Grant via drush (role machine name):
```
drush role:perm:add reviewer 'view any unpublished content'
drush role:perm:add editor 'view any unpublished article content'
```

After enabling the module or changing these permissions, rebuild node access if
listings look wrong: **Reports → Status → Rebuild permissions** (`drush php:eval 'node_access_rebuild();'`).
