# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) and **Views** module (`views`) — both part of
  Drupal core and enabled on most sites. Node stores the advisories; Views powers the
  listings and dashboard.

No third-party PHP libraries or external services are required. The module defines
three permissions (see below). It is **not covered by Drupal's security advisory
policy** and is described as **minimally maintained** — factor that into your risk
assessment before deploying it.

## Install with Composer

From the project root:

```bash
composer require drupal/security_advisories_nl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/security_advisories_nl -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en security_advisories_nl -y
```

Core's Node and Views will be enabled as dependencies if they are not already on. You
can also enable it from **Extend** (`/admin/modules`).

## After enabling

1. Add one or more advisory **sources** and run a first fetch — see
   [Configuration](../configuration/index.md).
2. Make sure **cron** is running so the fetch queue processes regularly (hourly is
   recommended for critical sources).
3. Under **People → Permissions**, keep **administer security advisories nl** to
   trusted staff only — it controls which external URLs the site fetches from — and
   grant **view security advisories** to the audience you want to read the listing.
