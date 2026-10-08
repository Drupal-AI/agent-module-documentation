<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Registration Role

## Config object — `registration_role.setting`

**Singular `setting`.** `drush cget registration_role.settings` will fail.

```yaml
role_to_select:            # sequence of role ids that get granted
  - member
  - newsletter
registration_mode: user    # 'user' | 'admin'
```

Install defaults are `role_to_select: {}` and `registration_mode: 'user'`.
Schema: `config/schema/registration_role.schema.yml` (`role_to_select` = sequence of string,
`registration_mode` = string).

| `registration_mode` | Label on the form | Effect |
|---|---|---|
| `user` | User self registration | roles granted only when an **anonymous** visitor registers (uid 0 and not CLI) |
| `admin` | Both user self registration and user creation by admin | also granted when a logged-in user **or a CLI/Drush script** creates the account |

## Read the live setup

```bash
drush cget registration_role.setting
drush cget registration_role.setting role_to_select
drush cget registration_role.setting registration_mode
```

## Set it with Drush

```bash
drush cset registration_role.setting registration_mode admin -y

# role_to_select is a sequence -> easiest from PHP
drush php:eval '
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", ["member"])
    ->set("registration_mode", "admin")
    ->save();
'
```

To stop assigning anything, set `role_to_select` to `[]`.

## Via the UI

1. *People → Registration Role* (`/admin/people/registration-role`), or the **Registration
   Role** tab on `/admin/people`.
2. **Roles to Assign** — checkboxes of every role except `authenticated`. Required.
3. **Registration mode** — radios, *User self registration* or *Both user self registration
   and user creation by admin*. Required.
4. Save. The submit handler `array_filter()`s the checkboxes, so only ticked roles are stored.

## Verify it works

Under Drush the current user is uid 0 **but** `PHP_SAPI === 'cli'`, so a Drush-created user
only gets the roles when `registration_mode` is `admin`:

```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", ["member"])->set("registration_mode", "admin")->save();
  $u = \Drupal\user\Entity\User::create(["name" => "rr_probe", "mail" => "rr_probe@example.com", "status" => 1]);
  $u->save();
  print implode(",", $u->getRoles()) . "\n";     // authenticated,member
  $u->delete();
'
```

## Gotchas

- Roles are only added on **`$user->isNew()`** — editing an existing user never re-applies
  them, and removing a role by hand is not undone.
- The config key is `role_to_select` even though it can hold several roles.
- Legacy (pre-2.0) config stored unselected roles as `0`; the presave hook skips falsy values
  and `registration_role_update_10001()` strips them — run `drush updb` after upgrading and
  read the warning it logs (see [api/assignment-logic.md](../api/assignment-logic.md)).
- The `authenticated` role is removed from the form options, so you cannot select it.
- Because the module reacts to `hook_ENTITY_TYPE_presave`, it also fires for accounts created
  by migrations, feeds and other modules — decide `registration_mode` accordingly.
