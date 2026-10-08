# Installation

## Requirements

- **PHP 8.1 or newer** — the module uses PHP 8 attributes, so this is a hard
  requirement.
- **Drupal core `^10.2 || ^11`**.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bca -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bca -y
```

There is nothing to configure. With the module enabled, add its attribute to your
bundle classes as described in the [overview](../index.md#how-to-use-it) and the
[`agent/`](../agent/start.md) docs.
