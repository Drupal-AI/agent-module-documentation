# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`), enabled automatically as a
  dependency. This is the only dependency.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/straw -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/straw -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en straw -y
```

The module ships no submodules and has no settings page. After enabling it, turn
Straw on for a specific term-reference field by setting its reference method and
widget — see [How to use it](../index.md#how-to-use-it).
