# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No additional contrib module dependencies and no PHP library requirements.
- A **HubSpot account** so you have a tracking ID (portal ID) to enter.

## Install with Composer

From the project root:

```bash
composer require drupal/hubspot_connect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hubspot_connect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hubspot_connect -y
```

## Verify it worked

Enter your HubSpot tracking ID on the settings form (see
[Configuration](../configuration/index.md)), then load a page on your site and
check the page source or your browser's network tab — you should see HubSpot's
tracking script loading. HubSpot's own tracking dashboard should begin showing
visits shortly afterward.
