<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domino configuration (`domino.settings`) & shipped install config

## Install & enable

```bash
composer require drupal/domino
drush en domino -y   # also enables config_split + reroute_email
```

`hook_install()` (`domino.install`) just calls `domino_cache_flush()`, which runs the full
setup pass (create anonymous/super-admin rows, secure super-admin, create test users). There is
**no settings form** — Domino is configured entirely from `settings.php`/`settings.*.php` per
environment. `domino_update_8802` installs Reroute Email if missing; `domino_update_8803`
initialises the MailSlurp keys.

## The `domino.settings` config object

All defaults from `config/install/domino.settings.yml`. **No `config/schema/` ships**, so these
keys have no schema; set them via `$config['domino.settings'][...]` in `settings.php`.

| Key | Default | Meaning |
|---|---|---|
| `application_mode` | `production` | `development` \| `staging` \| `production`. Gates almost every feature (see `ApplicationInterface`). |
| `display_emails_as_messages` | `0` | Non-prod: show emails to test users as Drupal messages instead of sending. |
| `mailslurp_key` | `''` | MailSlurp `x-api-key` for the email-delivery test feature. |
| `mailslurp_inbox_id` | `''` | Default MailSlurp inbox id (overridable per-request by the `domino_test_email_inbox` cookie). |
| `test_email_delivery` | `0` | Reroute mail to the MailSlurp inbox above. |
| `super_admin_user_check_frequency` | `3600` | Seconds between super-admin fallback checks. |
| `test_users_check_frequency` | `3600` | Seconds between test-user fallback checks. |
| `test_users_active_on_production` | `{}` | Test usernames to keep enabled on production (requires `test_users_password_for_production`). |
| `test_users_additional_users` | `{}` | Map of extra `username => role_id` test users. |
| `test_users_email_domain` | `''` | Domain for generated test-user emails (**required** to create test users). |
| `test_users_email_prefix` | `''` | Prefix for generated test-user emails. |
| `test_users_email_suffix` | `''` | Suffix for generated test-user emails. |
| `test_users_password` | `''` | Shared password for all test users (**required** to set passwords). |
| `test_users_password_for_production` | `''` | Password for the users kept active on production. |
| `test_users_usernames_map` | `{}` | Map `role_machine_name => alias` for nicer `alias.test` usernames. |
| `status_message_display` | `0` | Non-prod: show a message on every page. |
| `status_message_content` | `''` | The message text. |
| `status_message_type` | `''` | `status` \| `warning` \| `error` (falls back to `status`). |

### Minimal per-environment example

```php
// settings.php (all environments): pick the mode.
$config['domino.settings']['application_mode'] = getenv('APPLICATION_MODE'); // or 'production'
$config['domino.settings']['test_users_password'] = getenv('TEST_USERS_PASSWORD');
$config['domino.settings']['test_users_email_domain'] = 'example.com';
$config['domino.settings']['test_users_email_prefix'] = 'dev+';

// settings.dev.php (non-production): enable Reroute Email so mail is never sent to real users.
$config['reroute_email.settings']['enable'] = TRUE;
$config['reroute_email.settings']['address'] = 'test@example.com';
```

## Other shipped install config

- **Config Split** — `config_split.config_split.development|staging|production`
  (`config/install/`). Each ships `status: false`, `storage: folder`,
  `folder: ../config/split/<env>`. Activate the right one per environment in `settings.*.php`
  (`$config['config_split.config_split.<env>']['status'] = TRUE;`) and point `folder` at your split
  directory. Domino only provides the definitions; it does not switch them.
- **Roles** — `user.role.developer` (`weight: 2`, `is_admin: true`) and `user.role.manager`
  (`weight: 3`, `is_admin: null`). Naming convention only; **Manager permissions are not
  pre-configured** — assign them yourself.
- **Features bundle** — `config/optional/features.bundle.domino.yml` (`machine_name: domino`),
  installed only if the Features module is present, so you can pull config updates from Domino.
