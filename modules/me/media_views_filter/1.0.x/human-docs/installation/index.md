# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** and **Media** modules enabled (both ship with Drupal core).

There are no third‑party Composer or PHP library requirements, and no contrib
dependencies. Note that this is currently a **release candidate** (1.0.0‑rc1) and
is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/media_views_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_views_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_views_filter -y
```

## Verify it worked

Edit a media view at **Structure → Views** and add a filter criterion. In the
picker you should now see **"Media name/file name"**; under Fields you should see
**"File name"** and **"Alt text"**. If those appear, the plugins are registered —
follow "How to use it" on the [overview page](../index.md) to wire them into your
view.
