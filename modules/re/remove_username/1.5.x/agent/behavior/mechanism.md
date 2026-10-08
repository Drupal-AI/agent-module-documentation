<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Remove Username works

Everything lives in `remove_username.module` + `remove_username.install`. There is nothing
to configure; enabling the module is the whole setup.

## Form changes (all via `hook_form_FORM_ID_alter()`)

| Form ID | What the module does |
|---|---|
| `user_register_form` | Hides `account][name` (`#access = FALSE`, `#required = FALSE`); makes `account][mail` `#required`; prepends `remove_username_prepare_form_user_values` validator; appends `remove_username_form_user_post_validate`. |
| `user_form` (account edit) | Same field hiding + mail-required + prepends the prepare validator. |
| `user_login_form` | Only relabels `name['#title']` to "Email address". |
| `user_pass` (password reset) | Only relabels `name['#title']` to "Email address". |
| `commerce_checkout_flow` (BASE_FORM_ID) | Relabels the returning-customer `name` field to "Email address"; hides the register `name` field; prepends `remove_username_commerce_checkout_prepare_form`. |

`remove_username_prepare_form_user_values()` reads the submitted `mail`, and:
1. If `user_load_by_name($email)` returns another account, sets an error on `mail`
   ("The username %value is already taken.").
2. Runs `user_validate_name($email)` and surfaces any error on `mail`.
3. `$form_state->setValue('name', $email)` — copies email into the username value.

`remove_username_form_user_post_validate()` (register form only) drops any error keyed on the
hidden `name` element so the user never sees an error about a field they cannot see.

## The core mechanism: `hook_ENTITY_TYPE_presave()`

```php
function remove_username_user_presave(\Drupal\user\UserInterface $user) {
  if ($mail = $user->getEmail()) {
    $user->setUsername($mail);
  }
}
```

This runs on **every** user save (UI, Drush, migration, custom code), so an account's
`name` is always forced to its email. The username column still exists and Drupal's
uniqueness constraint on `name` still applies — Remove Username only hides the field and
keeps it in sync with the email.

## Install hook

`remove_username_install()` loads all users, skips anonymous, logs users with no email, and
for the rest calls `$user->setUsername($user->getEmail())->save()` — a one-time backfill so
existing accounts adopt the email-as-username rule immediately.

## Notes for agents

- To create a user "the Remove Username way", just set the email; the presave hook makes
  `name == mail` regardless of what you pass as the name.
- There is no setting to turn any of this off per-form; uninstall the module to revert
  (existing usernames stay whatever they were last saved as — i.e. the email).
