# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no additional module dependencies and no third‑party Composer or PHP
library requirements. The module is aimed at decoupled setups, so in practice you
will also be running a front-end framework (Nuxt, Vue.js, etc.) and often the
GraphQL module — but neither is required to install Frontend Routes itself.

## Install with Composer

From the project root:

```bash
composer require drupal/frontend_routing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontend_routing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontend_routing -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Frontend
Routing** (`/admin/config/services/frontend-routing`). You should see the screen
for adding keyed routes. From here, continue to
[Configuration](../configuration/index.md) to create your first route mapping.
