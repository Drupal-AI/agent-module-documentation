# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other modules are required — it extends core's Form API `#states` directly.

There are no third‑party Composer or PHP library requirements, and the module is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/form_state_empty -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_state_empty -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_state_empty -y
```

## Verify it worked

There is no admin page to check. The simplest way to confirm it works is to add
an `empty` condition to a field's `#states` (see the example on the
[overview page](../index.md)), load that form, and change the controlling field —
the target field's value should clear when the condition is met. If the field
empties as expected, the module is doing its job.
