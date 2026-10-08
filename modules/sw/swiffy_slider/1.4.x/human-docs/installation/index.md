# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module dependencies, and no submodules.
- The Swiffy Slider JavaScript library — but **the module already ships it**, so
  there is nothing extra to download for a standard install.

## Install with Composer

From the project root:

```bash
composer require drupal/swiffy_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swiffy_slider -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swiffy_slider -y
```

Because the library is bundled, the module is ready to use once enabled.

## Optional: override the bundled library version

If you want a specific (for example newer) release of the Swiffy Slider library,
you can override the bundled copy:

1. Add a package repository to your project's `composer.json`, inside
   `repositories`:

   ```json
   {
     "type": "package",
     "package": {
       "type": "drupal-library",
       "name": "dynamicweb/swiffy-slider",
       "version": "v1.6.0",
       "dist": {
         "url": "https://github.com/dynamicweb/swiffy-slider/archive/refs/tags/v1.6.0.zip",
         "type": "zip"
       }
     }
   }
   ```

2. Require the library:

   ```bash
   composer require dynamicweb/swiffy-slider
   ```

3. The already‑enabled module will use it.

## Next step

Set up a field formatter or a Views display and paste your configuration URL — see
[Configuration](../configuration/index.md).
