# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this version targets Drupal 11
  only.
- Core's **Field** module (`field`) and **Media** module (`media`), which Drupal
  will enable as dependencies when you turn on Easy Carousel.
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_carousel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_carousel -y
```

Drupal will pull in the **Field** and **Media** dependencies automatically.

## Verify it worked

Log in as an administrator and look under **Content** for the new **Carousels** and
**Carousels Items** listings. When you go to place a block (*Structure → Block
layout → Place block*), you should also find an **Easy Carousel** block available.
From there, follow the "How to use it" steps in the [overview](../index.md).
