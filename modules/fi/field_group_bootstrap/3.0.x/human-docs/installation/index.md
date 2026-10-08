# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **Field Group** module (`drupal/field_group`, version `^3 || ^4`), which is
  a hard dependency and provides the grouping UI this module extends.
- A **Bootstrap 5‑based theme** for the formatters to render correctly. This is
  not enforced by Composer, but without Bootstrap 5's CSS and JavaScript the
  groups won't look or behave as intended.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_bootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in **Field Group**
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_bootstrap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_bootstrap -y
```

Enabling it also enables **Field Group** if it isn't already on. There are no
submodules and no configuration step — the new Bootstrap formatters appear
immediately in the Field Group UI.

## Verify it worked

Go to any entity's **Manage form display** or **Manage display**, click **Add
group**, and open the **Format** select. You should see the Bootstrap options
(Bootstrap Accordion, Bootstrap Tabs, Bootstrap Card, and so on) alongside Field
Group's built‑in formats. See the [overview](../index.md) for how to use each one.
