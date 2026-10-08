# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

This module has no module dependencies and no third-party Composer or PHP
library requirements — it simply provides the Graupl JavaScript library.

## Install with Composer

From the project root:

```bash
composer require drupal/graupl_libraries -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graupl_libraries -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graupl_libraries -y
```

Most of the time you won't enable this by hand — a Graupl-based module or theme
lists it as a dependency and Drupal turns it on for you.

## Verify it worked

There is no settings page and no visible change on its own. It is working once it
is enabled and a consuming module or theme (for example Graupl Components) can
attach its library. Confirm it is enabled with
`drush pm:list | grep graupl_libraries`.
