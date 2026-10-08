# Installation

## Requirements

- **Drupal 10.3 or later, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Recurring Dates Field** module (`date_recur`), **3.x** — this provides the
  recurring‑date field type the widget is for.
- **PHP** as required by your installed Drupal core version.
- No third‑party Composer or library requirements.

> This is a **beta** release (3.0.0‑beta1). Recurrence data is hard to fix once
> saved incorrectly, so test timezone handling and include/exclude dates carefully
> before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/date_recur_interactive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Recurring Dates
Field and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_recur_interactive -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_recur_interactive -y
```

If Recurring Dates Field is not yet enabled, Drush will enable it as a dependency.

## Verify it worked

Edit the **Manage form display** of an entity that has a `date_recur` field. In the
**Widget** dropdown for that field you should now see the **Date Recur Interactive**
widget as an option. Select it, save, and open the entity's edit form — you should
get the visual recurrence editor with an occurrence preview. See
["How to use it"](../index.md#how-to-use-it) for the full steps.
