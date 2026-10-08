<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Policy integration & reset flow

## Password Policy route wiring

change_pwd_page has no config of its own, but it **writes one key into Password Policy's config** so that
policy enforcement follows the separate page. In `change_pwd_page.install`, on `hook_install`,
`hook_modules_installed` (when `password_policy` is installed later), and update 8001, it runs:

```php
\Drupal::configFactory()->getEditable('password_policy.settings')
  ->set('change_password_route', 'change_pwd_page.change_password_form')
  ->save();
```

So the correct value of `password_policy.settings:change_password_route` on a site running this module is
**`change_pwd_page.change_password_form`** — the route of the *form* page, not the
`change_pwd_page.change_password` redirect route.

Read / set it:

```bash
drush config:get password_policy.settings change_password_route
drush config:set password_policy.settings change_password_route change_pwd_page.change_password_form -y
```

If Password Policy is not installed, none of this applies and the key is absent.

## Runtime hooks with Password Policy

When both modules are on, `hook_form_alter()` on the separate `change_pwd_form`:
- adds the `password_policy_status` constraints table (when it should be visible),
- appends `_password_policy_user_profile_form_validate`, an after-build, and the policy submit handler,
so policies are validated on the separate form rather than the account edit form.
`change_pwd_page_password_policy_form_ids_alter()` also registers `change_pwd_form` with Password Policy.

## One-time login / reset flow

`RouteSubscriber` shortens `user.reset` to `/user/reset/{uid}/{timestamp}/{hash}/new`. The custom
`resetPass` controller validates the hash/timeout, then shows `ChangePasswordResetForm`. Its submit logs
the user in, stores a random token in `$_SESSION['pass_reset_' . $uid]`, and redirects to
`change_pwd_page.change_password_form` with `?pass-reset-token=<token>` so the change form can skip the
current-password check exactly once.
