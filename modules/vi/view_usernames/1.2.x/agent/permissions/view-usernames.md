# Permission: `view usernames`

Defined in `view_usernames.permissions.yml`. This is the only permission the module adds.

| Machine name | Title | Notes |
|---|---|---|
| `view usernames` | View usernames | Not `restrict access: true`. Its description warns that usernames may contain personal information, so granting it to Anonymous or all authenticated users re-opens the exposure — "Also modules like JSON API exposes all usernames with this permission." |

## What it does

The permission is one of the conditions checked by the shipped `DefaultViewUsernameAccessDecider`
(`src/DefaultViewUsernameAccessDecider.php`). A viewer sees another user's username when **any** of
these hold:

- the other account is **anonymous** (its label is always public), or
- the viewer **is** that account (you can always see your own username), or
- the viewer holds **`administer users`** (core permission), or
- the viewer holds **`view usernames`**.

Otherwise the default decider returns `AccessResult::forbidden()` (with cache tags
`user:<acting_uid>` and `config:user.role.<rid>` for each of the viewer's roles). If a site adds its
own decider, that decider can also grant access — see [../api/deciders.md](../api/deciders.md).

## Granting it

```bash
# Drush
drush role:perm:add editor 'view usernames'
drush role:perm:remove anonymous 'view usernames'
```

```php
// PHP
\Drupal\user\Entity\Role::load('editor')
  ->grantPermission('view usernames')
  ->save();
```

UI: `admin/people/permissions` (permission listed under the "View Usernames" module section).

## Caution

Granting `view usernames` to `anonymous` or `authenticated` restores core's default behavior (all
usernames visible), including through JSON:API and REST — which defeats the purpose of the module.
Grant it to specific trusted roles only.
