# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **User** module (`user`), which is always enabled.

This is an **alpha** release (1.0.0-alpha2) — test it before production use.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_user_accounts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/better_user_accounts -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_user_accounts -y
```

## Grant permissions

Better User Accounts defines its own permission(s). After enabling, go to
**People → Permissions** (`/admin/people/permissions`) and grant the relevant
permission to the roles that should receive the account-management
improvements. Users still need the usual core permissions (for example
*Administer users*) to manage other people's accounts.
