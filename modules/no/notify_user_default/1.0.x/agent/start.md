<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notify User Default (notify_user_default) — agent index

One form alter: the *Notify user of new account* checkbox on the admin user-register form defaults
to checked. No config, no permissions, no schema, no services, no Drush. Requires core `user`.

Key facts:
- Whole implementation:

  ```php
  function notify_user_default_form_user_register_form_alter(&$form, FormStateInterface $form_state, $form_id) {
    if (isset($form['account']['notify'])) {
      $form['account']['notify']['#default_value'] = TRUE;
    }
  }
  ```

- The `notify` element only appears when an **administrator** creates an account
  (`/admin/people/create`), so the public registration form is unaffected — the `isset()` guard is
  what makes that true.
- The checkbox stays editable; only its default changes.
- Also implements `hook_help()`.

Verification:

```bash
drush en notify_user_default -y
# Then load /admin/people/create as an admin: "Notify user of new account" is pre-ticked.
```

Notes:
- Programmatic account creation (`User::create()`, migrations, REST) never renders this form, so
  it is unaffected — send the welcome mail yourself with
  `_user_mail_notify('register_admin_created', $account)` if you need it there.
- Uninstalling restores core's unchecked default immediately; no data or config is left behind.
