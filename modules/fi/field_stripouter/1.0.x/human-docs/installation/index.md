# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A custom or sub‑theme where you can place a `field.html.twig` override — the
  module provides the flag, but your template does the actual markup stripping.

There are no other module dependencies and no third‑party libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/field_stripouter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_stripouter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_stripouter -y
```

## Verify it worked

Go to a **Manage display** screen (**Structure → Content types → *(type)* → Manage
display**) and open a field's formatter settings. You should see a **Strip outer
div** checkbox, and enabling it should add **"Outer divs stripped"** to the
formatter summary. To make it take visible effect, add the `stripouter_valueonly`
check to your theme's `field.html.twig` as shown in the
[overview](../index.md).
