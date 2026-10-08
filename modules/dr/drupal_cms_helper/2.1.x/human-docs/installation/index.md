# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`; the Composer
  constraint is `drupal/core: ^11.3.10`).
- Core's **Path Alias** module (`path_alias`), which Drupal enables
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

> **Already on Drupal CMS?** This module is bundled with Drupal CMS and is a
> required dependency of its recipes and site templates — it's almost certainly
> installed already, and you should **not** uninstall it.

## Install with Composer

If you need to add it to a plain Drupal 11 site, from the project root:

```bash
composer require drupal/drupal_cms_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_cms_helper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupal_cms_helper -y
```

## Verify it worked

Run `drush site:export --help`. If the command is listed (with its aliases
`siex` / `six`), the module is active. See [How to use
it](../index.md#how-to-use-it) for exporting a site as a recipe.
