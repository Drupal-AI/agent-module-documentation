# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Context](https://www.drupal.org/project/context)** module
  (`drupal/context ^4.0 || ^5.0`) — a required dependency. Composer installs it
  and Drupal enables it as a dependency.
- *Recommended:* the [Token](https://www.drupal.org/project/token) module (adds a
  token‑browser link on the breadcrumb form) and
  [Ctools](https://www.drupal.org/project/ctools) (used by Context for its
  condition system).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/context_breadcrumb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Context and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/context_breadcrumb -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en context_breadcrumb -y
```

Or enable **Context Breadcrumb** from **Extend** (`/admin/modules`). Context is
enabled at the same time if it is not already on.

There are no submodules. Continue to [Configuration](../configuration/index.md)
to define your first breadcrumb on a context.
