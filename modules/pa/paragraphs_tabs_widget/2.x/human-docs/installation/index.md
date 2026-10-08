# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Paragraphs** module (`paragraphs`, version 1.3 or newer) — a hard
  dependency, enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_tabs_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_tabs_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_tabs_widget -y
```

Drupal will enable Paragraphs automatically if it is not already on.

## Permissions

This module defines its own permission. After enabling, review it at
**People → Permissions** (`/admin/people/permissions`) and grant it to the roles
that should have access before relying on the widget in production.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then open a
content type's **Manage form display** and check that the tabs widget appears in
the widget list for your multi‑value Paragraphs field.
