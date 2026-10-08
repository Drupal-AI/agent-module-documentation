# Installation

## Requirements

Element Multiple is deliberately minimal. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies, no third‑party Composer packages, and no
front‑end libraries to download.

## Install with Composer

From the project root:

```bash
composer require drupal/element_multiple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/element_multiple -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en element_multiple -y
```

## Verify it worked

Because this module only provides a Form API element for developers, there is no
admin page to visit. To confirm it is working, add an `element_multiple` element
to one of your own forms (see the example in the [main guide](../index.md)) and
load that form — you should see a table of input rows with an "Add another"
button beneath it.
