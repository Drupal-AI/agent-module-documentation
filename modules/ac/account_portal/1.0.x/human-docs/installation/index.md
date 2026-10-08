# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The contributed **Consumers** module (`consumers:consumers`) — Account Portal is
  built on it. Composer installs it automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/account_portal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies (including Consumers) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/account_portal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en account_portal -y
```

## After enabling

Account Portal provides its own permissions — grant them to trusted administrator
roles at **People → Permissions** (`/admin/people/permissions`). Because the module
is authentication-adjacent, register your OAuth consumers deliberately, keep each
consumer's client secret in an environment variable or a Key entity rather than in
code or exported configuration, and review the redirect targets and scopes each
consumer is allowed.
