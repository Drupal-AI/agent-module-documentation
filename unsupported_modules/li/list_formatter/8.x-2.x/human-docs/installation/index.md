# Installation

## Requirements

List Formatter is deliberately lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Field** module (`field`), which is enabled on virtually every Drupal
  site and is pulled in automatically as a dependency.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/list_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/list_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en list_formatter -y
```

## Verify it worked

Go to the *Manage display* screen of any bundle that has a multi‑value or
long‑text field (for example **Structure → Content types → Article → Manage
display**). The field's **Format** dropdown should now offer the List formatter
option. Choose it, set the list type in the formatter settings, save, and view a
piece of content to confirm the values render as a list.
