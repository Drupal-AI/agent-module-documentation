# Installation

## Requirements

- **Drupal core `^10.3 || ^11`**.

There are no Composer library or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bcvb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bcvb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bcvb -y
```

After enabling, grant the module's permission under **People → Permissions** and
set up the bypass in code as described in the
[overview](../index.md#how-to-use-it). Remember that bypassing the view builder
also bypasses its field-access checks and sanitizing formatters — the custom
render path must re-apply both.
