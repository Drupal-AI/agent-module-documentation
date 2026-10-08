# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Plausible account** (Plausible Cloud) or a **self-hosted Plausible** instance,
  and a site/domain registered in it to receive the data.
- No third-party Composer or PHP libraries.

Visitors' browsers need to be able to reach your Plausible host for the script to load
and send events.

## Install with Composer

From the project root:

```bash
composer require drupal/plausible_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plausible_tracking -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plausible_tracking -y
```

## Verify it worked

Configure your domain and (if self-hosting) tracking host as described in
[Configuration](../configuration/index.md), then visit a front-end page as an
anonymous visitor and confirm the Plausible script is present (check the page source
or your browser's network tab), and that the visit shows up in your Plausible
dashboard.
