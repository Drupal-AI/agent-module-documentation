# Installation

## Requirements

Better Exposed Filters needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only Drupal dependency,
  and it is on by default on a standard install.
- The **noUiSlider** JavaScript library, brought in automatically through the
  `drupal/nouislider_js` Composer package. It is only used if you choose a slider
  widget, but Composer installs it with the module either way.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_exposed_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `drupal/nouislider_js` slider library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_exposed_filters -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_exposed_filters -y
```

Enabling the module adds **Better Exposed Filters** as a choice in the exposed
form settings of every view — it does not change any existing view until you
switch a view over to it. Head to [Configuration](../configuration/index.md) to do
that.
