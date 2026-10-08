# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). This module builds on core's
  Single Directory Components, which is a Drupal 11 feature, so earlier versions of
  core are not supported.

There are no dependent contrib modules, no third-party Composer packages, and no PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/shareable_sdc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shareable_sdc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shareable_sdc -y
```

There is no configuration form. Once enabled, create a top-level `/components`
directory in your project and place your Single Directory Components inside it —
Drupal will discover them globally.
