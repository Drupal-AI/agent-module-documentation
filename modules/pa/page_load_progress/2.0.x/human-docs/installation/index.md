# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Drupal core only — it uses core's jQuery and Drupal JavaScript. There are no contrib or PHP
  library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/page_load_progress -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/page_load_progress -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_load_progress -y
```

There are no submodules. After enabling, grant the **Use page load progress** permission to the
roles that should see the throbber, then tune the behavior on the settings form — see
[Configuration](../configuration/index.md).
