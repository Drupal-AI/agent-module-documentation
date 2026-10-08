# Installation

## Requirements

Configuration Normalizer is a small library module with minimal requirements:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).

It has no module dependencies of its own and no third-party Composer or PHP
library requirements. It builds on core's configuration system, which is always
available.

## Install with Composer

From the project root:

```bash
composer require drupal/config_normalizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_normalizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_normalizer -y
```

That's all it takes. There is nothing to configure — the module simply makes its
`ConfigNormalizer` plugin type and normalized storage classes available to other
modules and to your own code. In many cases you won't enable it directly at all:
another config tool (such as Configuration Update Manager or Config Distro) lists
it as a dependency and Drupal turns it on for you.
