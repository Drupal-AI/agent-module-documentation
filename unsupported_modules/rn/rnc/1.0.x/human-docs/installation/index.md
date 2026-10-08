# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required.

There are no third-party Composer or PHP library requirements. Note this module is
**unsupported / obsolete** and not covered by Drupal's security advisory policy —
install it with that in mind.

## Install with Composer

From the project root:

```bash
composer require drupal/rnc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rnc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rnc -y
```

## Grant the permission

Random Name Chooser provides its own permission. Go to **People → Permissions**
(`/admin/people/permissions`), grant the module's permission to the roles that
should participate in draws, and save.

## Verify it worked

Log in as a user in one of the granted roles and confirm you can add a name to the
list and draw a match. See the "How to use it" section of the
[overview](../index.md) for the flow, including the spouse-constraint grouping.
