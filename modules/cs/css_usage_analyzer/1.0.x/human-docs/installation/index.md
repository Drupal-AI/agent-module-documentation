# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **System** and **User** modules (always present in a Drupal install) —
  these are the only dependencies.
- No third‑party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/css_usage_analyzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_usage_analyzer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_usage_analyzer -y
```

## Grant permissions

After enabling, go to **People → Permissions** (`/admin/people/permissions`) and
grant:

- **`access css usage analyzer`** — to roles that should view the dashboard and
  reports.
- **`administer css usage analyzer`** — to roles that should manage the tool.

This is developer‑facing tooling, so keep both permissions to trusted roles.

## Verify it worked

Log in as a user who holds `access css usage analyzer` and open the **CSS Usage
Analyzer** dashboard from the admin menu. You should see CSS size metrics and
unused‑CSS reporting for your site. See the [main guide](../index.md#how-to-use-it)
for how to work through the findings.
