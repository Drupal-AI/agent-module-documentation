# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** module (`field`), which Drupal enables as a dependency. This is
  the only dependency.
- No extra Composer libraries or PHP-version requirements.

The condition plugins the field offers come from core and any contrib modules you
have installed, so which conditions are available depends on your site.

## Install with Composer

From the project root:

```bash
composer require drupal/condition_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/condition_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en condition_field -y
```

There are no submodules and no settings form. Once enabled, the **Condition
plugin field** type becomes available when adding a field to any content type or
other fieldable entity. See the [overview](../index.md) for how to add and use it.
