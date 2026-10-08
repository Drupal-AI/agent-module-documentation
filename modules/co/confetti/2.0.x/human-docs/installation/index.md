# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies. The
[canvas-confetti](https://github.com/catdad/canvas-confetti) JavaScript library
is loaded from a public CDN (jsDelivr) at runtime, so there is nothing extra to
download — but the effect does require visitors' browsers to be able to reach
that CDN.

## Install with Composer

From the project root:

```bash
composer require drupal/confetti -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confetti -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confetti -y
```

## Verify it worked

Open the module's settings form, enter a URL sub-path where the effect should
appear, save, and clear the cache. Visit that page — the confetti animation
should play.
