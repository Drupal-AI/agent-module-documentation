<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Administrator-only login & password reset

The whole module is one file, `administrator_login.module`. It adds a role check to two core
forms and provides nothing else (no routes, services, config, permissions, or install hooks).

## Install / enable

```
drush en administrator_login -y
```

No configuration step — there is no settings form and no config object. The behavior is active
as soon as the module is enabled. Requires core `user` (already present). Core `^10 || ^11`.

## Mechanism

`administrator_login_form_alter(&$form, FormStateInterface $form_state, $form_id)` implements
`hook_form_alter` and appends a validate handler to two forms:

| Form id | Validate handler appended | Purpose |
| --- | --- | --- |
| `user_login_form` | `administrator_login_validate()` | login form |
| `user_pass` | `administrator_login_reset_validate()` | forgotten-password / reset form |

Both handlers do the same lookup:

```php
$username = $form_state->getValue('name');
$users = \Drupal::entityTypeManager()->getStorage('user')
  ->loadByProperties(['name' => $username]);
if ($users) {
  $user = reset($users);
  if ($user->hasRole('administrator')) {
    return; // allowed — let core validation continue
  }
}
$form_state->setErrorByName('name', t('…')); // blocked
```

- `administrator_login_validate()` blocks with *"You are not authorised to log in."*
- `administrator_login_reset_validate()` blocks with *"This service is unavailable. If you
  encounter login issues, please contact the administrator."*

The handler is **appended** (`$form['#validate'][] = …`), so it runs alongside core's own
validators — it only adds a rejection; it never replaces core's credential check and never logs
anyone in on its own.

## Operating notes

- The allowed role is the literal string `administrator` (`$user->hasRole('administrator')`).
  There is no setting to change it. On a site whose administrator role has a different machine
  name (or no such role), these forms would reject everyone — grant the `administrator` role, or
  do not enable this module.
- `loadByProperties(['name' => …])` is an entity-storage query (parameterized) — no raw SQL.
- To remove the restriction, uninstall the module; the two forms return to stock core behavior.
