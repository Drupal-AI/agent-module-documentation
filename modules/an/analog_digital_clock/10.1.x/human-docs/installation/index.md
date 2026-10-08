# Installation

## Requirements

- **Drupal 8, 9, 10, or 11**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- For the **analog clock face skin only**: the third-party **snap.svg** library,
  placed at `libraries/snap.svg/snap.svg-min.js`. The three digital skins need no
  extra library.

## Install with Composer

From the project root:

```bash
composer require drupal/analog_digital_clock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/analog_digital_clock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analog_digital_clock -y
```

## Optional: add snap.svg for the analog skin

If you want to use the **analog clock face**, download the snap.svg library and
place its minified file at:

```
libraries/snap.svg/snap.svg-min.js
```

(See the module's README for details.) The digital skins work without this.

## Next steps

Choose a skin on the settings form at `/admin/config/analog_digital_clock`, then
place the **Analog Digital Clock** block from **Structure → Block layout**. See
the [overview](../index.md) for the details.
