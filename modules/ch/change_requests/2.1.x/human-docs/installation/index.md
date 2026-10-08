# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Changed Fields API** (`changed_fields`) module, which the change‑request
  engine builds on — Composer pulls it in automatically as a dependency.
- Text changes use Google's third‑party **diff‑match‑patch** library (the PHP
  port by yetanotherape); this comes in through Composer with the module.
- No special PHP libraries beyond that.

## Install with Composer

From the project root:

```bash
composer require drupal/change_requests -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Changed
Fields API dependency and the diff‑match‑patch library and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/change_requests -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en change_requests -y
```

## Verify it worked

After enabling, visit **People → Permissions** and confirm the Change Requests
permissions are present, then grant them to the appropriate roles. Open a node as
an authorised user and confirm you can submit an edit as a change request and
review it through the diff interface.
