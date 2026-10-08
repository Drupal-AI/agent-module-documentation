# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core **Options** (`options`), **Node** (`node`) and **Views** (`views`) modules,
  enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

> **Note on the release.** This is a release‑candidate line (`8.x-1.7-rc1`). It
> works, but treat feed validity as something to monitor since Google's specs move on
> their own schedule.

## Install with Composer

From the project root:

```bash
composer require drupal/google_feeds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_feeds -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_feeds -y
```

## Verify it worked

Go to **Structure → Views** and create or edit a View. When you set the display's
**Format**, you should now see **Google News feed** and **Google Shopping feed**
among the available formats. From there, follow "How to use it" on the
[overview page](../index.md#how-to-use-it) to build your feed.
