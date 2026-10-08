# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`), which ships with Drupal and is enabled as a
  dependency automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multi_value_add_hider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multi_value_add_hider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multi_value_add_hider -y
```

There is nothing to configure — the behavior applies immediately.

## Verify it worked

Edit any content that has an **unlimited** multi‑value field which already holds at
least one value. The trailing empty "add another" row should no longer appear
automatically; you add a new value deliberately instead. An empty field still shows
one row so you can start entering values.
