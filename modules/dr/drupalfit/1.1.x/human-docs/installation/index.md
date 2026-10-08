# Installation

## Requirements

- **Drupal 10.2 or higher** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or higher**.
- Core **System** and **Update** modules (`system`, `update`) — enabled
  automatically as dependencies.
- *(Only if you connect to the platform)* a **DrupalFit.com** account and an API
  key, plus outbound network access from your site to the DrupalFit platform.

## Install with Composer

From the project root:

```bash
composer require drupal/drupalfit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalfit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalfit -y
```

## Submodules

DrupalFit ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DrupalFit Report Export** | `drupalfit_report_export` | Adds the ability to export DrupalFit report results. |

Enable it only if you need report export:

```bash
drush en drupalfit_report_export -y
```

> Exported reports can contain detailed site and configuration information —
> treat them as sensitive and share them only with people who should see that
> data.

## Grant the permissions

DrupalFit provides two permissions, managed at **People → Permissions**
(`/admin/people/permissions`):

- **View DrupalFit reports** — view audit reports and results.
- **Administer DrupalFit** — manage settings and the API/platform configuration.

Because the reports reveal operational detail about the site, grant both only to
trusted administrator roles.

## Verify it worked

Log in as a user with **View DrupalFit reports** and go to **Reports → DrupalFit
Report** (`/admin/reports/drupalfit-report`). The Analysis Report tab should show
an overall site score and findings. To tune the optional platform connection, see
[Configuration](../configuration/index.md).
