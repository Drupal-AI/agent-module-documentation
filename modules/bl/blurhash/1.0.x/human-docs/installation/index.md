# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).

There are no third‑party Composer or PHP library requirements declared, and the
module adds no routes or permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/blurhash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/blurhash -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blurhash -y
```

Enabling the module makes the **Blurhash service** available. Producing the
blurred previews then requires integrating that service into your image display —
see [How to use it](../index.md#how-to-use-it).
