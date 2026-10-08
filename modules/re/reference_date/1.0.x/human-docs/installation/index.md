# Installation

## Requirements

Reference Date is lightweight. It needs:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Datetime** module (`datetime`) enabled — this is the only dependency,
  and Drupal enables it automatically when you turn on Reference Date.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reference_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reference_date -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reference_date -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click
**Create a new field**. The field-type list should now include **Reference Date
Combo**. Add it to a bundle, and check that the autocomplete widget lets you pick
a referenced entity and enter a date. See the parent
[guide](../index.md#how-to-use-it) for the full field setup walkthrough.
