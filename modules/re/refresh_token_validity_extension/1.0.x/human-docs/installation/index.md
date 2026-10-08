# Installation

## Requirements

This module is a companion to an existing OAuth2 SMTP mail setup. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHPMailer OAuth2** (`phpmailer_oauth2`) — enabled and configured with a
  working Azure app registration and an initial refresh token.
- **Ultimate Cron** (`ultimate_cron`) — enabled; it schedules and runs the monthly
  job.

Both dependencies are **mandatory** — the module does nothing useful without them.
There are no third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/refresh_token_validity_extension -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the required modules if they aren't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/refresh_token_validity_extension -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en refresh_token_validity_extension -y
```

This also enables `phpmailer_oauth2` and `ultimate_cron` if they are present but
not yet enabled.

## Verify it worked

1. Confirm PHPMailer OAuth2 SMTP mail is already working (send a test mail).
2. Go to the **Ultimate Cron** jobs list under **Configuration → System → Cron**
   and confirm the *OAuth Refresh Token Validity Extension* job is listed.
3. Run that job manually, then check the **Azure SMTP OAuth** logger channel for a
   success message confirming the refresh token was rotated. See the parent
   [guide](../index.md#how-to-use-it) for details.
