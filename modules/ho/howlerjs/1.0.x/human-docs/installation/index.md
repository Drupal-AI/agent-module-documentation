# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other Drupal modules and no third‑party Composer or PHP libraries are
  required — the module bundles what it needs to declare the Howler asset library.

## Install with Composer

From the project root:

```bash
composer require drupal/howlerjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/howlerjs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en howlerjs -y
```

## Verify it worked

There's nothing visible to check in the UI — this module only registers an asset
library. To confirm it's working, attach the library from your own code (or install
a module/player that depends on it) and load a page that uses it; the Howler
JavaScript should then be present and the global `Howl` API available. If you're not
attaching it from any code yet, enabling the module simply makes the library
available for when you do.
