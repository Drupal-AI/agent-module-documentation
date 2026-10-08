# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10.0 || ^11`).
- The **Facets** module, including its **Facets Form** and **searchbox widget**
  sub‑modules — this module extends the searchbox widget so it works inside a
  Facets Form, so those pieces need to be present and enabled.

There are no third‑party PHP library requirements. This project is **not covered by
Drupal's security advisory policy**, so review it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_form_searchbox_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_form_searchbox_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_form_searchbox_widget -y
```

Make sure the Facets module along with its Facets Form and searchbox widget
sub‑modules are also enabled, since this module builds on them.

## Verify it worked

Edit a facet that is shown through a Facets Form at **Configuration → Search and
metadata → Facets** (`/admin/config/search/facets`) and confirm the searchbox
widget is available to select. Choose it, save, and load the page to confirm the
type‑to‑filter box appears on the facet.
