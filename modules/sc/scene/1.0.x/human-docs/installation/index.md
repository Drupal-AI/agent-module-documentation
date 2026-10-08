# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Scene.js** JavaScript library, downloaded from its GitHub project (latest
  version). See the module's own README for the exact placement steps for your
  build. If you want to add video or audio components to a scene, Scene.js also
  offers a separate `@scenejs/media` library.

There are no module dependencies and no additional PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scene -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scene -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the Scene.js library

The module integrates Scene.js but does not bundle the library itself. Download
the latest Scene.js library from its GitHub project and place it where the module
expects it — follow the instructions in the module's `README.md` for the exact
path.

## Enable the module

```bash
drush en scene -y
```

## Verify it worked

With the module enabled and the library in place, build a small test animation in
your theme or a component and confirm Scene.js runs on the page. If the animation
does not appear, re‑check the library path against the module's README.
