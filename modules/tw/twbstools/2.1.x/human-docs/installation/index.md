# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- The **Bootstrap 5 theme** installed and providing its Bootstrap library. The
  module's `.info.yml` declares no hard module dependencies, so this is a *soft*
  requirement — but the `/styleguide` page's styling depends on the theme's
  `bootstrap5` library. Without it the page loads but renders unstyled.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/twbstools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twbstools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twbstools -y
```

That's all there is to it. Visit **`/styleguide`** (or **Configuration →
Development → Styleguide**) to see the cheatsheet. There is no configuration.
