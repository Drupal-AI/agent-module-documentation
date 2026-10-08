# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer libraries and no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/accessibility_statement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/accessibility_statement -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessibility_statement -y
```

On install the module adds a footer menu link pointing at the (still empty)
statement page. Next, open the settings form and fill in your statement — see
[Configuration](../configuration/index.md).
