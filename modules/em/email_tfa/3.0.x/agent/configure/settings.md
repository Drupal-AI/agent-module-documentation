<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Email TFA

Settings form route `email_tfa.settings` → `/admin/config/people/email-tfa`
(menu: People » Email TFA settings; permission `administer email tfa`). Config-translatable.
Everything is stored in the config object **`email_tfa.settings`** (defaults from `config/install`).

**Prerequisite:** a non-empty `hash_salt` must be set in `settings.php` (the form warns otherwise) —
the one-time code hash depends on it.

## Config keys (with shipped defaults)

```yaml
# email_tfa.settings
status: false                       # master on/off switch. FALSE = TFA inactive.
tracks: globally_enabled            # 'globally_enabled' (all users) OR 'optionally_by_users'
                                    #   (each user opts in via the email_tfa_status field)
user_one: false                     # exclude user 1 from TFA (only when globally_enabled)
role_exclusion_type: disable_for    # 'disable_for' = skip TFA for ignore_role users;
                                    # 'force_for'   = require TFA only for ignore_role users
ignore_role: {  }                   # list of role IDs the exclusion type applies to
dev_mode: false                     # WARNING: shows the code on the page (testing only)
log_events: false                   # log email/login TFA events
timeouts: 300                       # seconds a code stays valid (form requires >= 60)
security_code_length: 4             # digits in the code; select 4–9
flood_threshold: 5                  # max TFA events per user per window
flood_window: 3600                  # flood window in seconds (default 1 hour)
routes: "email_tfa.verifiy\r\nuser.logout"   # route names excluded from the TFA interrupt
subject: 'One Time Password'        # OTP email subject
body: "Dear [user:name], ... [user:email_tfa] ... [site:name] team"   # OTP email body
# Verification-form text (all translatable):
security_code_label_text, security_code_description_text,
security_code_verify_text, security_code_resend_text,
verification_succeeded_message, verification_failed_message,
verification_not_authorized_message
```

### Email body tokens

`body` is passed through the token system with a custom `[user:email_tfa]` replacement (the code),
plus standard tokens like `[user:name]` and `[site:name]`. `subject` is `Xss::filter`ed and `body`
is `Xss::filterAdmin`ed. Sent via `hook_mail` key `send_email_tfa`.

## Enabling — two modes (`tracks`)

- **`globally_enabled`** — TFA applies to all users, minus `user_one` and the role rules
  (`role_exclusion_type` + `ignore_role`).
- **`optionally_by_users`** — TFA only for users who tick the **Active** checkbox
  (`email_tfa_status` boolean base field) on their own account form. The account-form checkbox is
  hidden unless `status` is on and `tracks` is `optionally_by_users`.

## Read / write with drush

```bash
drush cget email_tfa.settings
drush cset email_tfa.settings status true -y
drush cset email_tfa.settings tracks globally_enabled -y
drush cset email_tfa.settings security_code_length 6 -y
drush cset email_tfa.settings timeouts 600 -y
```

Sequence/list keys (`ignore_role`) are easiest via `drush php:eval`:

```php
$c = \Drupal::configFactory()->getEditable('email_tfa.settings');
$c->set('role_exclusion_type', 'force_for');
$c->set('ignore_role', ['editor', 'administrator']);
$c->save();
```

Validation (from the form): `timeouts` must be ≥ 60; `security_code_length` must be 4–9.
