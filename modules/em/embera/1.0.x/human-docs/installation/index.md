# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Embera PHP library**, which is installed automatically into `/vendor/`
  when you install this module with Composer.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/embera -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Embera PHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/embera -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en embera -y
```

## Verify it worked

Because Embera is a developer‑facing service module, there is no admin page to
check. To confirm it's available, verify the `embera.manager` service resolves —
for example from a Drush PHP shell:

```bash
drush php:eval "var_dump(\Drupal::hasService('embera.manager'));"
```

A result of `true` means the service is registered and ready for other code to
use.
