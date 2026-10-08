# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is enabled by default on a standard install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/date_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_filter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_filter -y
```

There are **no submodules**, no permissions and no configuration to set. From the
moment it is enabled, every date filter in Views is the improved version.

## Verify it worked

Edit any view (**Structure → Views**), add an **Authored on** filter under *Filter
criteria*, and confirm you see a **Filter type: Date / Date and time** choice
(instead of core's "A date / An offset" radios). Expose the filter, save, and view
the page — the exposed filter should render a native date picker.

For how to configure a date filter on a view, see the "How to use it" section of the
[overview](../index.md).
