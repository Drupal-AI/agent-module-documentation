# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No additional contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/batch_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch_plugin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch_plugin -y
```

There is nothing to configure — define and run your batch plugins from code. See
[How to use it](../index.md#how-to-use-it).
