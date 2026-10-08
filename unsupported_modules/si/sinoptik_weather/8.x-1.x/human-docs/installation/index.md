# Installation

## Requirements

- **Drupal 8 or 9** (`core_version_requirement: ^8 || ^9`).
- **PHP 5.6** or later.
- No other Drupal modules or PHP libraries are required. The weather informer itself is
  drawn by remote assets loaded from **sinoptik.ua**, so the block needs outbound
  access to that third-party service — and using it means agreeing to sinoptik.ua's
  terms, conditions and user agreement.

## Install with Composer

From the project root:

```bash
composer require drupal/sinoptik_weather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sinoptik_weather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sinoptik_weather -y
```

## Verify it worked

Go to **Structure → Block layout** and confirm that the **Sinoptik.ua Weather
Informer** block is now available to place. Placing and configuring that block (see the
[main guide](../index.md)) is how you display the weather — there is no separate
settings page.
