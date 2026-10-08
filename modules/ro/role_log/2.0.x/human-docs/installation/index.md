# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A core log viewer to read the entries — **Database Logging** (`dblog`) or
  **Syslog**. Enable one if it is not already on.
- No third-party Composer or PHP libraries, and no other contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/role_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_log -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_log -y
```

## Verify it worked

Grant or revoke a role for a test user, then go to **Reports → Recent log messages**
(`/admin/reports/dblog`, with Database Logging enabled) and confirm an "info" entry
recording the change appears. That confirms Role Log is capturing role changes —
there is nothing to configure.
