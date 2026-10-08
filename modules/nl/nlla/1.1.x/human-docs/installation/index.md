# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). The effect relies
  on native lazy loading, available since Drupal 9.1.
- No other modules, and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/nlla -W
```

Note that the Composer package is `drupal/nlla`, even though the module's
machine name is `native_lazy_load_animation`. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nlla -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `native_lazy_load_animation`:

```bash
drush en native_lazy_load_animation -y
```

## Verify it worked

Load a front-end page that has images below the fold and scroll down. As each
lazy-loaded image arrives it should fade in rather than appear instantly. There
is no settings page to check — if the module is enabled, the effect is active.
