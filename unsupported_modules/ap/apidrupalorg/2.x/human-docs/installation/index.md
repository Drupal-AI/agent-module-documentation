# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`).
- The contributed **API** module (`api`, the code-documentation module that powers
  api.drupal.org) — this is what the whole module extends.

Drupal enables Views automatically as a dependency. You must have the API module
available as well; install it the same way (`composer require drupal/api`) if it
is not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/apidrupalorg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apidrupalorg -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apidrupalorg -y
```

There are no submodules. Once enabled, the path processor is active immediately;
the footer block and the comments importer are used from the admin UI — see
[Configuration](../configuration/index.md).
