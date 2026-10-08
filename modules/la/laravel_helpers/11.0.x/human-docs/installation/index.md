# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- This is a **developer library** module — it is only useful if you (or another
  module) write code against it. There is no site‑builder feature to enable
  separately.

There are no additional contrib module dependencies. The Laravel components it
wraps are pulled in through Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/laravel_helpers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Laravel
library packages and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/laravel_helpers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en laravel_helpers -y
```

There is no configuration to do — the helpers and validation are now available to
your code.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`). The real
check is in code: for example, attach a `#laravel_validators` rule to a form
element in a test form and confirm the validation fires as expected, or call one
of the Laravel string/array helpers from a custom controller.
