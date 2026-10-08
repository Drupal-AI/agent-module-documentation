# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) — enabled automatically as a dependency.
- Core's **Responsive Image** module (`responsive_image`) — enabled automatically
  as a dependency.

There are no third‑party Composer or PHP library requirements.

Before you can use the formatter you'll want at least one **responsive image
style** defined at **Configuration → Media → Responsive image styles**
(`/admin/config/media/responsive-image-style`), since the formatter renders images
through one.

## Install with Composer

From the project root:

```bash
composer require drupal/umf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/umf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en umf -y
```

This also enables the `media` and `responsive_image` dependencies if they aren't
already on. Next, see [Configuration](../configuration/index.md) to enable the
formatter on a field.
