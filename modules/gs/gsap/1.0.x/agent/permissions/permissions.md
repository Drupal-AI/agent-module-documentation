# Permissions

Defined in `gsap.permissions.yml`.

| Permission | Title | Grants |
|---|---|---|
| `administer gsap` | Administer GSAP | The settings form (`gsap.settings`) and all `gsap` config-entity CRUD routes (collection, add, edit, delete). |

- It is the `admin_permission` on the `gsap` config entity type (`src/Entity/Gsap.php`) and the
  `_permission` requirement on every route in `gsap.routing.yml`.
- No other permissions are defined. There is no view-only or per-entity permission — a role
  either can administer everything GSAP or nothing.

Grant via drush:

```bash
drush role:perm:add editor 'administer gsap'
```
