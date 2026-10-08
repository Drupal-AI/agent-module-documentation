# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Migrate** module (`migrate`) — enabled automatically as a dependency.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_helper -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_helper -y
```

Core Migrate is enabled automatically if it is not already on.

## Verify it worked

The module defines its own permissions to gate its tools — review them at
**People → Permissions** (`/admin/people/permissions`) and grant them to the
developers or site builders who manage your migrations. Once enabled, the helper
tabs and actions become available on your migrations and migrated entities. There
is no configuration form to fill in.
