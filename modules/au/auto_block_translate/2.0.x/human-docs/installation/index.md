# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A multilingual site set up for content translation, plus a **translation
  service** for the module to hand block content to.

The module declares no hard module dependencies and no third-party Composer
library requirements, but it is only useful on a site configured for
translation.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_block_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_block_translate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_block_translate -y
```

After enabling, configure the translator and which blocks should be translated —
see [Configuration](../configuration/index.md).
