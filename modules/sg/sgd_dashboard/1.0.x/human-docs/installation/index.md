# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10||^11`).
- Core's **Views** (`views`) and **Taxonomy** (`taxonomy`) modules.
- Several contrib modules the dashboard builds on: **Twig Tweak**, **Ultimate
  Cron**, **Better Exposed Filters** and **Entityreference Filter**. Composer pulls
  these in as dependencies.
- The companion **Site Guardian Dashboard API** module (running on the sites you
  monitor, so it can hand out API keys), and optionally the **Site Guardian PDF
  Report** module if you want PDF status reports.
- No third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sgd_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what brings in Views' companion contrib modules
above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sgd_dashboard -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sgd_dashboard -y
```

This pulls in and enables its dependencies as well.

## Next steps

There's no settings form. Add a **client** node, then a **website** node configured
with a monitored site's details and its Site Guardian API key, and open the **Site
Guardian Dashboard** from the admin menu. See the "How to use it" section of the
[main guide](../index.md). Keep the dashboard restricted to trusted admins.
