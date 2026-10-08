# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).

The module has no other module dependencies and no third‑party Composer or PHP
library requirements. (Core's **Views** and **User** modules, enabled on virtually
every site, are what the module's Views fields and profile integration build on.)

## Install with Composer

From the project root:

```bash
composer require drupal/friendship -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/friendship -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en friendship -y
```

## Verify it worked

Go to **Configuration → People** and confirm the **Friendship settings** page is
available at `/admin/config/people/friendship-settings`. The module provides its own
permissions, so also review **People → Permissions** and grant the friend‑management
permissions to the roles that should have them. Then follow
[Configuration](../configuration/index.md) to place the friendship link on user
profiles.
