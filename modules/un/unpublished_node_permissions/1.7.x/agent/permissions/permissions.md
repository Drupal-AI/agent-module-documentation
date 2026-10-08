<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions, node grants & Views integration

## Permissions defined

| Permission | Source | Gates |
|---|---|---|
| `view unpublished content` | `unpublished_node_permissions.permissions.yml` (static; title "View any unpublished content") | Viewing **any** unpublished node, all types. |
| `view <type> unpublished content` | dynamic, per node type — `UnpublishedNodePermissions::nodeTypePermissions` (a `permission_callbacks` entry, class extends core `\Drupal\node\NodePermissions`) | Viewing unpublished nodes of that **one** type, e.g. `view article unpublished content`, `view page unpublished content`. |

The dynamic permission machine name is literally `view {machine_name} unpublished content`. One is
generated for every node type that exists, so the list grows/shrinks with your content types.

Grant them on **People → Permissions** (`/admin/people/permissions`) or programmatically:

```php
\Drupal\user\Entity\Role::load('content_editor')
  ->grantPermission('view article unpublished content')
  ->save();
```
```bash
drush role:perm:add content_editor 'view article unpublished content'
```

## How access is enforced (node grant system)

`hook_node_access_records(NodeInterface $node)` — for each **unpublished** translation it writes
`grant_view` records in three realms:

- `view_unpublished_<type>_node` (gid 1)
- `view_unpublished_any` (gid 1)
- `view_unpublished_author` (gid = node owner uid)

Published translations instead get a record in the core `all` realm (normal visibility).

`hook_node_grants(AccountInterface $account, $operation)` — only for `view`:

- for every node type the user holds `view <type> unpublished content` → grants realm
  `view_unpublished_<type>_node` = [1];
- if the user holds `view unpublished content` → grants realm `view_unpublished_any` = [1];
- if the user holds `view own unpublished content` → grants realm `view_unpublished_author` =
  [account uid] (this "own" permission is honored if present, but is not itself defined by this
  module).

**Important:** node grants are cached in the `node_access` table. After enabling the module or
changing who holds these permissions, rebuild:

```bash
drush php:eval 'node_access_rebuild();'
```

## Views integration

- `hook_views_plugins_filter_alter()` replaces the `node_status` filter plugin class with
  `\Drupal\unpublished_node_permissions\Plugin\views\filter\UnpublishedStatus`.
- `hook_views_query_substitutions()` provides substitution tokens
  `***VIEWUNPUBLISHED_TYPE_<type>***` (1/0 = current user holds `view <type> unpublished content`)
  and `***VIEWUNPUBLISHED_ANY***` (1/0 = holds `view unpublished content`), so Views listings show
  unpublished rows consistently with the per-type permissions.

No configuration entities, schema, or settings form — everything is permissions + grants.
