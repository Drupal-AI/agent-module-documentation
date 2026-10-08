# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).

There are no dependent contrib modules, no third-party Composer packages, and no PHP
library requirements. You will, of course, need a SharpSpring account to get the
tracking details you enter on the settings form.

## Install with Composer

From the project root:

```bash
composer require drupal/sharpspring -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharpspring -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharpspring -y
```

## Next step

Enabling the module does not start tracking on its own — you need to enter your
SharpSpring account details first. See [Configuration](../configuration/index.md).
