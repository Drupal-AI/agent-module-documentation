# Installation

## Requirements

Office Hours is lightweight and relies only on Drupal core:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Datetime** (`datetime`) modules — Drupal
  enables these automatically as dependencies when you turn on Office Hours.

There are no third‑party Composer or PHP library requirements. The module
*optionally* works with Diff (field‑level diffs), Feeds (bulk import), and Webform
(use office hours as a form element) if you happen to have those installed, but
none of them are required.

## Install with Composer

From the project root:

```bash
composer require drupal/office_hours -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/office_hours -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en office_hours -y
```

Office Hours ships **no submodules** — this single module gives you the field
type, widgets, formatters, and Views integration.

## Next steps

Because Office Hours is a field type, there is nothing to configure globally.
Head to **Structure → Content types → (your type) → Manage fields → Add field**,
choose **Office hours**, and set your widget and formatter — see the
[overview](../index.md#how-to-use-it) for the full walkthrough.
