# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core **Views** (`views`).
- The contributed **Domain** (Domain Access) module (`domain`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_views_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This release is an alpha; if Composer does not resolve it
under your stability settings, request it explicitly (for example
`composer require 'drupal/domain_views_display:^1.0@alpha' -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_views_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_views_display -y
```

Drupal will prompt to enable Views and Domain as dependencies if they are not
already on.

## Verify it worked

Edit any view (**Structure → Views**). In a display, you should now see a
**Domain overrides** field group with an **Override display** link. Being able to
open it and pick a per‑domain display confirms the module is active. See the "How
to use it" section of the [overview](../index.md) for the full workflow.
