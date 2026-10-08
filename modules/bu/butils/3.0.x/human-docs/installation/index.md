# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

Backend Utils has no other module dependencies and no third-party Composer or PHP
library requirements. It is a code-level library, so it is typically installed
because another custom module or your project code depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/butils -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/butils -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en butils -y
```

There is no configuration. Once enabled, the `butils` service is available to your
code and the Twig extension is available to your templates — see the
[overview](../index.md#how-to-use-it).
