# Configure — settings & cache tags

**Config object:** `msqrole.settings` (has schema; ships `config/install` default).
**UI:** `/admin/config/people/masquerade-role` (route `msqrole.settings_form`,
form `MasqueradeRoleSettings`). **Permission:** `administer masquerade role` (restricted).

## The one setting

| Key | Type | Default | Meaning |
|---|---|---|---|
| `tags_to_invalidate` | text | `''` | Newline/whitespace list of **extra** cache tags to invalidate whenever a user activates or resets masquerade. |

Why it exists: switching effective roles can leave stale, permission-varying markup in Drupal's
render cache. The module always invalidates a fixed list
(`RoleManagerInterface::TAGS_TO_INVALIDATE` — local tasks/actions blocks, the admin/account/tools
menus, `local_task`, `local_action`, and the current `user:<uid>` tag). If a specific block or
element still shows/hides incorrectly after switching roles, add **its** cache tag here so it is
cleared too.

## Set it with drush

```bash
drush cset msqrole.settings tags_to_invalidate 'config:block.block.sidebar_menu' -y
drush cget msqrole.settings tags_to_invalidate
```

The module also registers the `msqrole_is_active` **cache context** (service
`cache_context.msqrole_is_active`) so render caches vary by masquerade state — this is separate
from `tags_to_invalidate` and needs no configuration.
