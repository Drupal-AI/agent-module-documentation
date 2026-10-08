# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Field** module (`field`) — it ships with Drupal core and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/html_script_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_script_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_script_formatter -y
```

## Verify it worked

Go to a bundle's **Manage display** (for example **Structure → Content types →
*(type)* → Manage display**). For a text or string field, the **Format** dropdown
should now list **HTML Script Formatter** as an option.

> **Before you apply it,** re‑read the note in the
> [overview](../index.md): this formatter renders field values unescaped and should
> only ever be used on fields editable exclusively by fully‑trusted administrators.
