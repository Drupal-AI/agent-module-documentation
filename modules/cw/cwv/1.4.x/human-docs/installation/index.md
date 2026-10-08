# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No module dependencies and no third‑party PHP or JavaScript library downloads —
  the `web-vitals` script is bundled with the module and served from your own
  site.

## Install with Composer

From the project root:

```bash
composer require drupal/cwv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cwv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cwv -y
```

## Verify it worked

Log in as a user with the **View CWV reports** permission and visit **Reports →
CWV** (`/admin/reports/cwv`). The report pages should load. They will be empty
until you **enable capture** — remember that CWV collects nothing after install.
Head to [Configuration](../configuration/index.md) to turn capture on and set
your sampling and URL‑storage policy.
