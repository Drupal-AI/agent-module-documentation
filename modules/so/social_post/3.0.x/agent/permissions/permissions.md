# Permissions

Declared in `social_post.permissions.yml` (all three are non-administrative and off by default):

| Permission | Title | Purpose |
| --- | --- | --- |
| `view social post user entity lists` | View Social Post user entity lists | View the per-provider list of connected accounts. |
| `delete social post user accounts` | Delete Social Post user accounts | Delete connected accounts belonging to any Drupal user. |
| `delete own social post user accounts` | Delete own Social Post user accounts | Delete connected accounts belonging to the current user. |

## Where they are enforced

- **Route `entity.social_post.delete_form`** requires `delete own social post user accounts`
  (see `social_post.routing.yml`). This is the route behind the "Delete" operation on the
  connected-account lists and on the user edit form.
- **Entity access** — `Drupal\social_post\UserAccessControlHandler::checkAccess()` grants the
  `view` operation to holders of `view social post user entity lists` **or**
  `delete own social post user accounts` (OR semantics).
- **Entity `admin_permission`** on the `social_post` entity type is core's
  `administer site configuration` — holders of it are always granted entity access.

## Other permissions this module relies on

- `administer social api autoposting` gates the integrations admin page
  (`social_post.integrations`). It is **provided by Social API**, not by this module.

## Grant via drush / PHP

```bash
drush role:perm:add authenticated 'delete own social post user accounts'
```

```php
user_role_grant_permissions('authenticated', ['view social post user entity lists']);
```
