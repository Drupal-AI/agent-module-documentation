# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Views** module (`views`), which ships with Drupal and must be enabled.
  It is pulled in automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contextual_filter_range_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contextual_filter_range_validator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contextual_filter_range_validator -y
```

## Verify it worked

Edit a view at **Structure → Views**, add or edit a contextual filter, and open
the **Specify validation criteria** section. The **Range** validator should now
appear in the *Validator* list, with **Minimum value** and **Maximum value**
options. That confirms the module is active.
