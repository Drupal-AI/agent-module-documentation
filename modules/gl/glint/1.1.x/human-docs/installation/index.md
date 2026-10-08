# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other modules or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/glint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/glint -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en glint -y
```

## Verify it worked

Glint has no UI, so verify it in code. In a preprocess hook, call
`\Drupal\glint\Glint::service()->get('some_reference_field', $entity)` against an
entity that has that field, and confirm you get back the cleaned value rather than
an error. If the `Drupal\glint\Glint` class resolves and returns a value, the
module is installed and working. Consult the module's **README** for the full API.
