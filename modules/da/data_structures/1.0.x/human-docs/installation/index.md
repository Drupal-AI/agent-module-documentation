# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Drush 13 or higher** — the code‑generation commands rely on it.
- No other Drupal module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/data_structures -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_structures -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_structures -y
```

## Verify it worked

Confirm the generators are available (Drush 13+ required):

```bash
drush generate --help data-structures:map
```

If Drush shows the generator, you are set. Generate a typed class with `drush
generate data-structures:map` or `drush generate data-structures:typed-sequence`,
or start extending the shipped sequence/set classes in your own code — see "How to
use it" on the [overview page](../index.md).
