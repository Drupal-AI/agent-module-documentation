# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **LocalGov Core** (`localgov_core`) and **Pathauto** (`pathauto`), plus core
  **Field**, **Link** and **Node** — Composer and Drupal pull these in.
- A **LocalGov Drupal** site — this is the base of the distribution's service model
  and expects the distribution to be present.
- If you want services to be **searchable**, the separate **LocalGov Search**
  (`localgov_search`) module — service search comes from there, not from this module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install LocalGov Core,
Pathauto and shared dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_services -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The core module does nothing on its own — enable it together with the submodules for
the parts of the service model you need:

```bash
drush en localgov_services localgov_services_landing localgov_services_page -y
```

## Submodules — enable what your site needs

| Submodule | What it provides |
|-----------|------------------|
| `localgov_services_landing` | Top‑level service landing pages |
| `localgov_services_sublanding` | Second‑level pages within a service |
| `localgov_services_page` | Ordinary content pages inside a service |
| `localgov_services_navigation` | Navigation shared by a service's pages (and for external pages linking in) |
| `localgov_services_status` | Status updates attached to a service landing page |

## Verify it worked

After enabling the submodules, go to **Content → Add content** — you should see the
service content types you enabled (Landing page, and so on). Create a Landing page and
check that its URL follows the service pattern and that it appears in the
**localgov-services-menu**.
