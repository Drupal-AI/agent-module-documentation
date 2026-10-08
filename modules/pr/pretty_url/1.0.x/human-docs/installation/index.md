# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) and **Taxonomy** module (`taxonomy`), which
  this module depends on — the feature applies to taxonomy exposed filters in
  Views. Drupal enables both automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pretty_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pretty_url -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pretty_url -y
```

## Verify it worked

Edit a view that has an exposed **taxonomy** filter (at **Structure → Views**),
open that filter's settings, and confirm you see the **"Enable pretty URL for this
filter"** checkbox. Tick it, save the view, then use the filter on the front end:
the URL should now read like `?category=web-development,drupal` instead of the
default `?category[12]=12`, and the results should be filtered correctly.
