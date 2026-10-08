# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Masquerade** module (`masquerade`) — this module extends it and Drupal
  enables it automatically as a dependency.
- A logging backend to benefit from the extra detail — core's **Database Logging**
  (`dblog`) is the usual choice; syslog and others work too.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/masquerade_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Masquerade
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/masquerade_log -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masquerade_log -y
```

Masquerade is enabled automatically as a dependency. There is no configuration
step and no settings page — enabling the module is the whole setup.

## Verify it worked

Masquerade as another user (via the Masquerade block or the *Masquerade as* link
on a user's profile), perform an action that writes to the log, then stop
masquerading and check **Reports → Recent log messages**
(`/admin/reports/dblog`). The entry created during the masquerade session should
show a `[masquerading <username>, uid <uid>]` note identifying the real user.
