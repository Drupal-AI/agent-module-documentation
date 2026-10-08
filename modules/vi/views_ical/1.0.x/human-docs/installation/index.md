# Installation

## Requirements

Views iCal needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the only Drupal dependency, and it is
  enabled by default on most sites.
- Two PHP libraries, which Composer installs for you automatically:
  **`eluceo/ical`** (`^0.17`, builds the calendar components) and
  **`html2text/html2text`** (`^4.0`, converts HTML descriptions to plain text).

Because those libraries come in through Composer, install the module with Composer
rather than by downloading a zip — that is how the libraries reach your site.

## Install with Composer

From the project root:

```bash
composer require drupal/views_ical -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the two bundled PHP
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_ical -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_ical -y
```

There is no configuration step and no settings page. Once the module is enabled,
the new iCal display, style and row plugins appear in the Views UI — see
[How to use it](../index.md#how-to-use-it) in the overview for building your first
feed.
