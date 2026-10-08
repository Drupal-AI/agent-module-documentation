# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Mail System** module (`mailsystem`) — Composer pulls it in
  automatically as a dependency; it is what lets you select Resend as the mail
  backend.
- A **Resend account** and an **API key**, plus a verified sending domain (or an
  `@resend.dev` address for testing).
- Outbound HTTPS access from your server to the Resend API.

> **Not covered by a security advisory.** This module is not covered by Drupal's
> security advisory policy, and it is currently an alpha release. Review it before
> relying on it for production mail.

## Install with Composer

From the project root:

```bash
composer require drupal/resend_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Mail System
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/resend_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en resend_api -y
```

Enabling this module also enables **Mail System** if it is not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → System → Resend API**
(`/admin/config/system/resend-api`). You should see the field for your Resend API
key. Next, follow [Configuration](../configuration/index.md) to store the key
securely, select the Resend backend in Mail System, and send a test message.
