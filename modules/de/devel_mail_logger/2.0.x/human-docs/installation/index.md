# Installation

## Requirements

Devel Mail Logger is deliberately minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's mail system — which every Drupal site already has.

There are no third-party Composer libraries, PHP extensions, or contrib module
dependencies. The optional [Mail System](https://www.drupal.org/project/mailsystem)
module is only needed if you want to route *some* mail keys through the logger
rather than all of them.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_mail_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_mail_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_mail_logger -y
```

Enabling the module creates the `devel_mail_logger` database table but does
**not** start capturing mail on its own. To activate the logger you must point
Drupal's mail system at it — see
[How to use it](../index.md#how-to-use-it) in the overview.

## Verify it worked

Once you have activated the mail backend, log in as a user with the
**`devel_mail_logger send test mail`** permission, go to
**Reports → Devel Mail Logger**, and click **Send test mail**. A new row should
appear in the log — open it to confirm you can read the captured subject,
recipient, and body.

> **Reminder:** never leave this mail backend active on a production site, or
> real outgoing email will be swallowed and stored in the database instead of
> being delivered.
