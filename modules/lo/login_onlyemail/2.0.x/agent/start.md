<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login with email only (login_onlyemail) — agent index

Makes the Drupal login form accept **only** an email address as the identifier, and
relabels the "Forgot your password" form to ask for an email. Core requirement `^10 || ^11`.

Key facts:
- The whole module is a single hook file (`login_onlyemail.module`) plus `.info.yml`,
  `README.md` and `LICENSE.txt`. No `src/`, no routes, no permissions, no config schema,
  no services, no Drush.
- **There is nothing to configure.** Enabling the module is the entire setup; the change is
  site-wide and unconditional — no per-role, per-path or per-form exemption exists.
- It touches two core forms via `hook_form_FORM_ID_alter()`:
  - `user_login_form` — relabels the identifier field to "Email address" and adds a validator
    that resolves the typed email to an account (via `user_load_by_mail`) before core's normal
    password/flood checks run. Username login stops working.
  - `user_pass` (forgot password) — relabels the field to "Email address" and adds a validator
    that looks the email up.
- Usernames still exist and are still used wherever Drupal displays an account name; this module
  does not turn the email address into the account's display name.
- If a site needs "username *or* email" at login rather than email-only, this is the wrong
  module — `email_registration` / `mail_login` accept both.
- Note the README caveat: disable this module before running core integration tests that call
  `drupalLogin()` (that helper submits a username).
- Uninstalling restores the stock forms, so it is cheap to trial.

```bash
drush en login_onlyemail -y     # that's the whole install
```

No solution docs: the module exposes no configuration, plugins, API, hooks, permissions or
Drush commands — enabling it is the complete surface.
