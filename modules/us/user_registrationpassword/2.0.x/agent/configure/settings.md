<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure User Registration Password

## Config objects

**`user_registrationpassword.settings`** (shipped defaults from `config/install`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `registration` | string | `with-pass` | Verification/password mode (see below). |
| `registration_ftll_expire` | boolean | `false` | Whether the activation ("first time login") link expires. |
| `registration_ftll_timeout` | integer | `86400` | Activation link lifetime in seconds (24 h). Only applies when expire is on. |
| `notify.register_confirmation_with_pass` | boolean | `true` | Whether the module sends its confirmation email. |
| `registration_redirect` | path | `''` | Path to send the user to after confirming (relative, leading `/`, may use user tokens, e.g. `/user/[user:uid]/edit`). |

**`user_registrationpassword.mail`** → `register_confirmation_with_pass.subject` and
`register_confirmation_with_pass.body` (the welcome/activation email; body includes
`[user:registrationpassword-url]`). `user_registrationpassword.mail_original` stores the core
default it replaced (used on uninstall).

## The three registration modes

`registration` accepts the constants on `\Drupal\user_registrationpassword\UserRegistrationPassword`:

| Value | Constant | Behaviour |
|---|---|---|
| `none` | `NO_VERIFICATION` | No verification email; user sets password on the registration form and can log in immediately. Sets core `user.settings:verify_mail` = 0. |
| `default` | `VERIFICATION_DEFAULT` | Verification email required; password is set later (classic core flow). Sets `verify_mail` = 1. |
| `with-pass` | `VERIFICATION_PASS` | Verification email required **but** the password is set on the registration form; the module sends its own activation mail that confirms + logs in. Default. |

When `with-pass` is combined with core "Visitors can create accounts" (`user.settings:register` =
`visitors`), the module disables core `verify_mail` and the `register_pending_approval` /
`register_no_approval_required` notifications and takes over the flow.

## Where it is configured

There is **no standalone form** — the module implements
`hook_form_user_admin_settings_alter()` to add its radios/fields to core's **Account settings**
page, route **`entity.user.admin_form`** at **`/admin/config/people/accounts`**. The added
"Welcome (no approval required, password is set)" email template section edits
`user_registrationpassword.mail`. A custom submit handler
(`user_registrationpassword_admin_settings_submit`) keeps `user.settings` in sync with the chosen
mode.

## Drush / config workflow

```bash
drush cget user_registrationpassword.settings

# Set the mode (no verification, password on the form)
drush cset user_registrationpassword.settings registration none -y

# Turn on activation-link expiry with a 2-hour lifetime
drush cset user_registrationpassword.settings registration_ftll_expire true -y
drush cset user_registrationpassword.settings registration_ftll_timeout 7200 -y
```

```php
\Drupal::configFactory()->getEditable('user_registrationpassword.settings')
  ->set('registration', 'with-pass')
  ->set('registration_ftll_expire', TRUE)
  ->set('registration_ftll_timeout', 7200)
  ->save();
```

Config translation: `user_registrationpassword.mail` is registered under the Account settings
config-translation mapping, so the email can be translated per language.
