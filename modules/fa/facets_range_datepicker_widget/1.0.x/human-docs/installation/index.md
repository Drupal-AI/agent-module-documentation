# Installation

## Requirements

- **Drupal 8.9 or newer** (`core_version_requirement: >=8.9`), including 9, 10, and
  11.
- The **Facets** module (`drupal/facets`) — this module provides widgets for it and
  cannot work without it. Composer pulls it in with the command below.
- A **Search API index with a date field exposed as a range facet** — the widget
  renders over an existing range facet, so this must be in place for the widget to
  do anything.

There are no third‑party PHP library requirements. This project **is covered by
Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_range_datepicker_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_range_datepicker_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_range_datepicker_widget -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Edit a facet built on a date field at **Configuration → Search and metadata →
Facets** (`/admin/config/search/facets`) and confirm the **Datepicker** and
**Range Datepicker** widgets now appear in the list of available widgets. Choose
one, save, and load the page where the facet is shown to confirm the calendar
picker renders.
