# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **User** module (`user`) — part of Drupal core and always available.
- No external libraries or third-party services are required for basic functionality.

**Recommended (optional) companions**, as suggested by the module:

- **Flood Control** — for extended rate-limiting capabilities.
- **Security Kit (Seckit)** — HTTP header protections and security hardening.
- **Syslog** — centralised log management and external monitoring.
- **CrowdSec Drupal module** — from version 1.0.2, lets this module emit CrowdSec
  signals for suspicious reset activity. Entirely optional, with no hard dependency.

The module provides two permissions: **view secure password reset logs** and
**administer secure password reset logs**.

## Install with Composer

From the project root:

```bash
composer require drupal/secure_password_reset_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/secure_password_reset_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en secure_password_reset_log -y
```

You can also enable it from **Extend** (`/admin/modules`).

## After enabling

1. Visit the settings page at **`/admin/config/security/password-reset-flood`** and
   review the logging, flood-control, and blocking options — see
   [Configuration](../configuration/index.md).
2. Under **People → Permissions**, grant **view secure password reset logs** only to
   trusted roles (the logs are security-sensitive) and keep **administer secure
   password reset logs** to administrators.
