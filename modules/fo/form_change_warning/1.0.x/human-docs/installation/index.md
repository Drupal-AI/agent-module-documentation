# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).

There are no other module dependencies.

> **Note:** This project is *minimally maintained* and, at the 1.0.x branch, an
> alpha release. Test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/form_change_warning -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_change_warning -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_change_warning -y
```

Enabling the module makes its JavaScript library available, but the warning does
not appear anywhere until you **attach the library** to a form — see "How to use
it" in the [main guide](../index.md).

## Verify it worked

After attaching the `form_change_warning/form_change_warning` library to a form,
open that form, change any field, and confirm the "unsaved changes" warning
appears at the top.
