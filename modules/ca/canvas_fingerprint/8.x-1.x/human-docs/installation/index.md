# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, Composer packages, or PHP libraries are required. The
  fingerprinting assets ship inside the module's own `assets/` directory.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_fingerprint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_fingerprint -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_fingerprint -y
```

There is no configuration to do. Visit `/fingerprint` to see the demo.
