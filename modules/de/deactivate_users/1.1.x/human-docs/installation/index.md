# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Token** module (`token`) — required, and used in the notification email
  templates. Composer pulls it in as a dependency.
- A working **cron** — the module does its blocking on cron, so cron must run
  regularly for it to have any effect.

There are no additional PHP or front-end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/deactivate_users -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/deactivate_users -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en deactivate_users -y
```

Drupal will enable Token as a dependency if it isn't already on.

## Verify it worked

Log in as a user with the **Administer site configuration** permission and go to
**Configuration → Users → Deactivate users**. You should see the settings form.
**Configure it before you rely on it** — set your inactivity limit, grace period,
and email templates on the [Configuration](../configuration/index.md) page, and
double-check that you won't accidentally block any service accounts. Nothing is
blocked until the thresholds are set and cron runs.
