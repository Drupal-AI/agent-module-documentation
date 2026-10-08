# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or newer**.
- Drupal core only — there are no contributed module dependencies and no network
  access is required.

Note this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/saudi_id_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/saudi_id_validator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en saudi_id_validator -y
```

There is no configuration to do. Once enabled, the validation service, the Form
API element validator and the `SaudiId` entity constraint are available for you to
use in your own code.

## Verify it worked

Add the `SaudiId` constraint to a test field, or call the
`saudi_id_validator.validator` service from a quick `drush php:eval`, and confirm
that a well‑formed National ID or Iqama passes while a number with a bad checksum
is rejected.
