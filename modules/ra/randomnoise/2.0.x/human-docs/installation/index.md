# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other Drupal modules are required. Note, however, that the module loads a
  remote script from `https://randomnoise.us` at runtime, so the effect depends
  on that external domain being reachable — and visitors' browsers must be able
  to reach it too.

## Install with Composer

From the project root:

```bash
composer require drupal/randomnoise -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/randomnoise -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en randomnoise -y
```

That's the entire setup — there is no configuration form and no permission to
grant.

## Verify it worked

Load any page as a visitor and view the page source (or your browser's network
tab). You should see the `randomnoise` library / `squawk.js` script attached. To
turn the behavior off again, uninstall the module.
