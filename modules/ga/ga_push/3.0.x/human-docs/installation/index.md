# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **Google Analytics 4** property to send events to.
- The **GA4 Measurement Protocol PHP library**
  (`br33f/php-GA4-Measurement-Protocol`) for server‑side GA4 pushes — Composer
  pulls it in as a dependency.

This documented release is a `3.0.0-alpha1` **alpha** — evaluate it before relying
on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ga_push -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the GA4
Measurement Protocol library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ga_push -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ga_push -y
```

## Verify it worked

Grant the **Admin GA Push** (`admin ga push`) permission to your administrator
role, then open the Google Analytics Push settings form under **Configuration**
and confirm it loads. After configuring your GA4 details (see
[Configuration](../configuration/index.md)), trigger a test event and check that
it appears in your GA4 property's realtime/DebugView reports.
