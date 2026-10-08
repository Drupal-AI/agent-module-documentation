# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  This wide range reflects intent rather than test coverage — because the element
  API belongs to Site Studio, verify against the Site Studio version you run.
- The **Acquia Site Studio** module (`cohesion`) — a hard dependency, and Acquia's
  commercial licensed product.
- Core **Views** (`views`), which Drupal enables by default.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_studio_views_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/site_studio_views_element -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_studio_views_element -y
```

There is no configuration form and no permissions to grant — the Views element
becomes available in the Site Studio builder immediately.

## Verify it worked

Open the Site Studio builder, edit or create a component, and confirm that
**Views Element** now appears in the element palette. Add it to a canvas and check
that its settings offer a list of your Views' block displays.
