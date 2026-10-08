# Installation

## Requirements

- **Drupal 11.3 or later, or Drupal 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **Views** module (`views`), which is part of a standard Drupal install.

## Install with Composer

From the project root:

```bash
composer require drupal/itunes_rss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/itunes_rss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en itunes_rss -y
```

Drupal enables the Views dependency at the same time if it is not already on.

## Verify it worked

Go to **Structure → Views** (`/admin/structure/views`), create or edit a View, and
add a **Feed** display. When you open the display's **Format / Style** options, the
**iTunes RSS** style should be available to select — that confirms the module is
installed and ready. See the overview page's "How to use it" for building the feed.
