# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no other modules
to enable — Maybe is a self‑contained developer utility.

## Install with Composer

From the project root:

```bash
composer require drupal/maybe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maybe -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maybe -y
```

Enabling the module makes the `maybe()` helper function and the
`Drupal\maybe\Maybe` class available. There is no configuration step.

## Verify it worked

The module works as soon as it's enabled — there's nothing to see in the admin UI.
To confirm it's available, use it from custom code (for example a theme preprocess
function):

```php
$output = maybe($entity)->label()->return();
```

If `$entity` is missing or the call chain can't complete, `$output` is simply `null`
rather than a fatal error — which is the whole point of the module.
