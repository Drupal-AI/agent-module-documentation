# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **Paragraphs** module (`paragraphs`) — a hard dependency, enabled
  automatically as a dependency.
- A **Bootstrap 5 theme** for correct styling of the tabs and pills. This is not
  a Composer dependency, but the front‑end output assumes Bootstrap 5 is present.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_tabs_bootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_tabs_bootstrap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_tabs_bootstrap -y
```

Drupal will enable Paragraphs automatically if it is not already on.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then open a
content type's **Manage form display** and **Manage display** and check that
**Paragraphs Tabs** is available as both a widget and a formatter for your
multi‑value Paragraphs field.
