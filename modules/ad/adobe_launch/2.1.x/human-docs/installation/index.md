# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **Adobe Launch / Adobe Experience Platform tag** container, so you have the
  script URL(s) to configure. The module injects your container; it does not
  provide one.

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/adobe_launch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adobe_launch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adobe_launch -y
```

Nothing is injected until you enter your Launch URLs and tick the master
**Enable** checkbox on the settings form. Go to **Configuration → Web services →
Adobe Launch** (`/admin/config/services/adobe_launch/configure`) — see
[Configuration](../configuration/index.md).
