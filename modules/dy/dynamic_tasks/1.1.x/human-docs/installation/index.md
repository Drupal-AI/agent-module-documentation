# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies.
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_tasks -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_tasks -y
```

## Verify it worked

Log in as an administrator and open the **Dynamic Local Tasks** listing from the
module's **Configure** link on the **Extend** page. You should see the
(initially empty) list of dynamic local tasks with an option to add a new one. From
there, follow [Configuration](../configuration/index.md).
