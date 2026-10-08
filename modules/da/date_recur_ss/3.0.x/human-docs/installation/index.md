# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Recurring Dates Field** module (`date_recur`), **3.2 or later** — this
  provides the interpreter system and the recurring‑date data model this plugin
  extends.
- **PHP 8.0 or later**.
- No third‑party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/date_recur_ss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Recurring Dates
Field and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_recur_ss -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_recur_ss -y
```

If Recurring Dates Field is not yet enabled, Drush will enable it as a dependency.

## Verify it worked

The module adds no page of its own. To confirm it's available, go to Date Recur's
**interpreter** configuration and create or edit an interpreter — the **SS** (`ss`)
interpreter plugin should now be selectable. Assign it to a recurring‑date field's
formatter and view content to see its phrasing in action. See
["How to use it"](../index.md#how-to-use-it) for the full steps.
