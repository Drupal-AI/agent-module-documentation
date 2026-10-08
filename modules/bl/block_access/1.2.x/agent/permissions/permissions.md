# Block Access — permissions

Block Access defines its permissions **dynamically**, not in a static `*.permissions.yml`
list. `block_access.permissions.yml` only declares:

```yaml
permission_callbacks:
  - \Drupal\block_access\Permissions::get
```

`Permissions::get()` loads every `block_content` type and, for each type `$id`, emits:

| Permission string | Status | Gates |
|---|---|---|
| `update own <id> block_content` | **active** | Edit content blocks the user authored |
| `delete own <id> block_content` | **active** | Delete content blocks the user authored |
| `create <id> block_content` | deprecated (removed in 2.0.0) | Create blocks of that type — use core `create <id> block content` |
| `update any <id> block_content` | deprecated (removed in 2.0.0) | Edit any block of that type — use core `edit any <id> block content` |
| `delete any <id> block_content` | deprecated (removed in 2.0.0) | Delete any block of that type — use core `delete any <id> block content` |

So on a site with a `basic` block type you get `update own basic block_content`,
`delete own basic block_content`, etc. Add a new block content type and its permissions
appear automatically (rebuild caches if needed).

## Block-add access override

`block_access.services.yml` registers:

- `block_access.route_subscriber` (`RouteSubscriber`) — on `block_content.add_form` it
  removes the default `_permission: administer blocks` requirement and replaces it with
  `_block_content_access_create: 'true'`.
- `block_access.access_check` (`CreateBlockContentTypeCheck`, tagged
  `access_check, applies_to: _block_content_access_create`) — allows access when the account
  has **`administer blocks` OR `create <type> block_content`** (checked with `OR`).

Net effect: a user can reach the "Add content block" form for a type if they hold either
`administer blocks` or that type's `create` permission.

## Granting them

There is no configure route (`configure: null`). Grant on **People → Permissions**
(`/admin/people/permissions`) or in config at `user.role.<role>.permissions` (an array of
permission strings). Example role config fragment:

```yaml
permissions:
  - 'update own basic block_content'
  - 'delete own basic block_content'
```

## Deprecation / upgrade note

The `create`/`update any`/`delete any` permissions are deprecated in `block_access:8.x-1.2`
and removed in `2.0.0`; core now provides `create <type> block content`,
`edit any <type> block content`, `delete any <type> block content`. The update hook
`block_access_update_8001()` migrates roles to those core permissions where an equivalent
exists, and tells you the module can be uninstalled if you use none of its permissions.
The `own`-scoped permissions remain the module's unique offering.
