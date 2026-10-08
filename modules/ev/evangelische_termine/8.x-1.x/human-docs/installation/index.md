# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The [**Colorbox**](https://www.drupal.org/project/colorbox) module (`colorbox`),
  which provides the lightbox used to display event details. Composer pulls it in as
  a dependency when you require Evangelische Termine.
- Outbound HTTPS access from your web server to your evangelische-termine.de host,
  since event data is fetched live at render time.

This project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/evangelische_termine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Colorbox.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/evangelische_termine -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en evangelische_termine -y
```

Drupal enables Colorbox automatically as a dependency.

## Verify it worked

Go to **Structure → Block layout** and click **Place block**. You should see the
Evangelische Termine blocks (filtered list, teaser/slider, and resource booking)
available to place. Add one to a region, set its organizer ID and host, and load a
front-end page to confirm events are fetched and displayed. See
[How to use it](../index.md#how-to-use-it) for the block-by-block walkthrough.
