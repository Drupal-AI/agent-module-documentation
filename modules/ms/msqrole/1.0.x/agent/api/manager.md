# API — the role manager service

Service **`msqrole.manager`** → `RoleManagerInterface` (`Drupal\msqrole\RoleManager`,
constructor deps: `user.data`, `entity_type.manager`, `config.factory`, `keyvalue`, `uuid`).
This is the programmatic entry point; there are no plugins and no Drush commands.

## Activating / reading masquerade state (per user, in `user.data`)

```php
$m = \Drupal::service('msqrole.manager');
$uid = \Drupal::currentUser()->id();

$m->setActive($uid, TRUE);                    // turn masquerade on
$m->setRoles($uid, ['content_editor']);       // set effective roles
$active = $m->isActive($uid);                 // bool
$roles  = $m->getRoles($uid);                 // current effective roles
$m->invalidateTags($uid);                     // clear the module's cache tags for this user
$m->removeData($uid);                         // fully reset (also done on logout)
```

State is stored via `UserDataInterface` under module name `msqrole`. The `current_user` service is
a `MasqueradeAccountProxy` and the `user` entity uses `MasqueradeRoleUser`, so once active the
account's `getRoles()` returns the masqueraded set while `id()` stays the real user.

## Generating shareable masquerade links

```php
/** @var \Drupal\Core\Url $url */
$url = $m->generateUrl(['content_editor'], $single_usage = FALSE, $url_options = []);
// -> Url to route 'msqrole.set' with ?key=<sha256(...)>
```

- Non-existent roles are stripped; an **empty** role list throws `\BadMethodCallException`.
- Persistent link key = `sha256(implode(',', $roles))`; single-use key = a random UUID.
- Entries are stored in the **`msqrole.urls`** key/value collection as
  `['persist' => bool, 'roles' => [...], 'created' => ts]`.
- `getRolesForKey($hash)` returns the roles (always adds `authenticated`) and deletes the entry if
  it was single-use.

## Routes that consume the manager

- `msqrole.set` (`/admin/people/masquerade-role/set?key=<hash>`) — activates the role set for the
  current user (`_custom_access` = `MasqueradeRoleController::access`, which calls
  `checkAccessForKey()`); marked `no_cache`.
- `msqrole.reset` (`/admin/people/masquerade-role/reset`) — clears masquerade; access allowed only
  when `isActive()` is true.
