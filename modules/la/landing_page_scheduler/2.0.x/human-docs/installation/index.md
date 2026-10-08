# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules outside of Drupal core, and no third‑party PHP libraries.

You'll also want at least one **node** to redirect to — the page that will serve as
your landing page during the scheduled window.

## Install with Composer

From the project root:

```bash
composer require drupal/landing_page_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/landing_page_scheduler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en landing_page_scheduler -y
```

## Assign the permission

The configuration page is permission‑gated. Go to **People → Permissions** and
grant the Landing Page Scheduler permission to the roles that should be allowed to
set up redirects (typically administrators or content managers).

## Verify it worked

Visit **Configuration → System → Landing Page Scheduler**
(`/admin/config/system/landing-page-scheduler`). You should see the form for
choosing a target page and time window, described in
[Configuration](../configuration/index.md).
