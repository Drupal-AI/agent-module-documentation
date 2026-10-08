# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party PHP libraries and no module dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/ipd_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ipd_validator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ipd_validator -y
```

## Verify it worked

There's no UI to check, so verify from code. Once enabled, the
`plugin.manager.ipd_validator` service is available — call it from a small snippet
(or `drush php:eval`) and confirm it validates a known document:

```php
$valid = \Drupal::service('plugin.manager.ipd_validator')->validate('20304050607', 'AR');
```

A boolean result confirms the service and its country validators are loaded. See
"How to use it" on the [overview page](../index.md) for the full API.
