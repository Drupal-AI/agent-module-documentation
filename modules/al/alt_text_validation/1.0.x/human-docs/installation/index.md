# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** and **Views** modules (Views is enabled on most sites).
- The contrib **[Views Data Export](https://www.drupal.org/project/views_data_export)** module
  at **1.5 or newer** (`drupal/views_data_export:^1.5`) — it provides the CSV download on the
  report. Composer pulls it in automatically.
- The **`league/commonmark`** PHP library (declared as a Composer dependency; installed for you
  by Composer).

## Install with Composer

From the project root:

```bash
composer require drupal/alt_text_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed —
here it also pulls in the Views Data Export module and the `league/commonmark` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/alt_text_validation -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alt_text_validation -y
```

Enabling it also enables its dependencies (Field, Views, Views Data Export). Six default rules
are installed and active immediately — see [Configuration](../configuration/index.md) if you
want to soften or disable any before editors hit them.

## Set the permissions

Two permissions are added at **People → Permissions** (`/admin/people/permissions`):

- **`administer alt text validation`** — the settings form and full control over the rules.
  Grant to administrators / site builders.
- **`view alt text validation reports`** — the Alt Text Report and its rebuild button. Note this
  report exposes alt text and titles from content across *all* entity types, so it is
  effectively a site-wide content-audit view — grant it to editorial / QA roles deliberately.

On-save alt-text validation itself is **not** permission-gated; it applies via a field
constraint to anyone editing a covered field, controlled by the master switch and each rule's
action.

There are no submodules.
