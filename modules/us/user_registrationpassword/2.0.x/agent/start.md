<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Registration Password — agent index

Lets visitors set their own password on the registration form even when email verification is
required, and sends one activation email that confirms + logs in. No dedicated settings page — it
**alters core's Account settings form** (`entity.user.admin_form`). Depends on core **user**.

- **Settings keys, the three registration modes, activation-link & email config, drush workflow** →
  [configure/settings.md](configure/settings.md)
- **The confirmation URL/token, confirm route, the mail, and the REST endpoint** →
  [api/flow.md](api/flow.md)

Key facts:
- Config object `user_registrationpassword.settings`: `registration` (`none` | `default` |
  `with-pass`; default `with-pass`), `registration_ftll_expire` (bool), `registration_ftll_timeout`
  (int seconds, default 86400), `registration_redirect` (path), `notify.register_confirmation_with_pass`.
- Mail config object `user_registrationpassword.mail` → `register_confirmation_with_pass.{subject,body}`.
- Configure at `/admin/config/people/accounts` (route `entity.user.admin_form`).
- Token `[user:registrationpassword-url]`; confirm route `user_registrationpassword.confirm`.
- REST resource `user_registrationpassword` at `/user/registerpass`.
- Constants `\Drupal\user_registrationpassword\UserRegistrationPassword`: `NO_VERIFICATION='none'`,
  `VERIFICATION_DEFAULT='default'`, `VERIFICATION_PASS='with-pass'`.
