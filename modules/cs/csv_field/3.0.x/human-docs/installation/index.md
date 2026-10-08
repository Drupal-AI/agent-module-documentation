# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** module (`file`) — a dependency, enabled automatically.
- The **PapaParse** JavaScript library (`papaparse`) — used to parse CSV in the
  browser for the client‑side rendering option. Installing via Composer with the
  right repositories configured pulls this in as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/csv_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the PapaParse asset library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csv_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

> **Note on the PapaParse library:** CSV Field expects the PapaParse asset library
> to be available (typically installed as `papaparse/papaparse`). If your project
> isn't already set up to install front‑end asset libraries via Composer, you may
> need the appropriate Composer repositories/installer configured so PapaParse
> lands in your libraries directory.

## Enable the module

```bash
drush en csv_field -y
```

Drupal enables the core File dependency automatically if it isn't already on.

## Verify it worked

Go to **Structure → Content types → *(type)* → Manage fields**, click **Add
field**, and confirm that **CSV** appears in the field‑type list. Add one, enter
some CSV on a piece of content, set the formatter on **Manage display**, and view
the content to confirm the table renders. See the [main guide](../index.md#how-to-use-it)
for the full walkthrough.
