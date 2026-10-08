<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration message mechanism (created_account_register_message)

All logic lives in `created_account_register_message.module`. There is no configuration; installing
and enabling the module is the entire setup. It only touches the **core user registration form**
(`user_register_form`), so the core registration flow must be enabled for it to have any effect.

## Install / enable

- `drush en created_account_register_message` (or via the Extend UI). No settings form, no
  permission, no config export. Requires core `user` (always present).

## The form alter

`created_account_register_message_form_user_register_form_alter(&$form, $form_state, $form_id)`
appends a validate callback:

```
$form['#validate'][] = 'carm_node_form_validate';
```

It runs after core's own validators, so it can inspect and clear the errors core produced.

## Validation: `carm_node_form_validate(&$form, $form_state)`

1. Reads `$form_state->getValue('mail')`; returns immediately if empty.
2. Runs an entity query:

   ```
   \Drupal::entityQuery('user')
     ->condition('mail', $mail)
     ->condition('status', 1)   // active accounts only
     ->execute();
   ```

   (A `login` condition is present but commented out in source.)
3. If no id is returned, it returns — registration proceeds normally with core's behavior.
4. Otherwise it loads the matched user (`array_pop($ids)` then `User::load($id)`) and stashes the id
   in a `drupal_static`:
   - `carm_user_nologin` when `$user->getLastLoginTime() == 0` (never logged in), else
   - `carm_user_login`.
5. Replaces the submit handlers with only its own and clears errors:

   ```
   $form_state->setSubmitHandlers(['carm_node_form_submit']);
   $form_state->clearErrors();
   ```

   This is what suppresses the core "This email is already in use" error **and** stops a duplicate
   account from being created — the default `RegisterForm` submit no longer runs.

## Submit: `carm_node_form_submit(&$form, $form_state)`

Reads the statics set during validation:

- **Never-logged-in account** (`carm_user_nologin`): sends the core notification mail and shows a
  status message.

  ```
  _user_mail_notify('register_admin_created', User::load($nologin));
  \Drupal::messenger()->addStatus(t('You already have an account, we have e-mailed a
    password reset link in case you do not remember your password.'));
  ```

  `register_admin_created` is the standard core mail key that includes a one-time login / password
  reset link, so the person can set a password and activate the account an admin created for them.

- **Previously-logged-in account** (`carm_user_login`): shows a status message with inline links,
  built from `Link::createFromRoute('login here', 'user.login')` and
  `Link::createFromRoute('reset your password here', 'user.pass')`, passed as the `@login` / `@reset`
  placeholders of a `t()` string. All strings are hardcoded and translatable; no user-supplied value
  is rendered.

## `hook_help`

`created_account_register_message_help()` returns a short "About" blurb on
`help.page.created_account_register_message`.

## Edge cases / operating notes

- Only **active** accounts (`status = 1`) trigger the message; blocked accounts fall through to
  core's normal handling.
- The distinction between the two messages is `getLastLoginTime() == 0`, i.e. the account has never
  had a successful login — not whether a password was ever set.
- Because it clears all errors on a mail match, any other validation error on the registration form
  is also cleared for that submission; the alter is specific to `user_register_form`, so other forms
  are unaffected.
- Function names use a `carm_node_form_*` prefix (legacy naming); they are plain functions, not
  services or plugins.
