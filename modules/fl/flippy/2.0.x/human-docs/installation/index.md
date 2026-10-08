# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).

There are no required module dependencies and no third-party libraries. Two
optional modules add extra features:

- **Token** (`drupal/token`) — adds a token browser to the label fields (token
  replacement works either way, but the browser makes it easier to pick tokens).
- **HammerJS** (`drupal/hammerjs`) — enables keyboard-arrow and touch-swipe
  navigation on the pager.

## Install with Composer

From the project root:

```bash
composer require drupal/flippy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional helpers:

```bash
composer require drupal/token drupal/hammerjs -W
drush en token hammerjs -y
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flippy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flippy -y
```

Flippy does nothing until you turn it on for a content type — see
[Configuration](../configuration/index.md).

This module has no submodules.
