# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer packages,
  PHP extensions, or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/days_ago -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/days_ago -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en days_ago -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a date or timestamp field)* →
Manage display**. The field's **Format** dropdown should now offer **Days ago**.
Select it, save, and view a piece of content — the date should render as a relative
time such as "3 days ago".
