# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No additional contrib module dependencies.

You will install and enable it on **both** ends — the environment that pushes
content and the environment that receives it.

## Install with Composer

From the project root:

```bash
composer require drupal/batch_content_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/batch_content_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en batch_content_sync -y
```

Then set up and **authenticate** the connection between environments before you
sync anything — see [How to use it](../index.md#how-to-use-it). Keep any
connection credentials in an environment variable, not in committed config.
