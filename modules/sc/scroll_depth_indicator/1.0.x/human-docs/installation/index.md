# Installation

## Requirements

Scroll Depth Indicator is lightweight:

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies, and no extra PHP or third-party library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scroll_depth_indicator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scroll_depth_indicator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scroll_depth_indicator -y
```

## Verify it worked

Visit a page of a content type the indicator applies to and scroll down — the
progress indicator should fill as you go. To choose where it attaches and which
content types it appears on, see [Configuration](../configuration/index.md).
