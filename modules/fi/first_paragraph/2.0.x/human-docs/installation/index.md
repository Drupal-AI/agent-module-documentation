# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Field** module (`field`) enabled — it's part of Drupal core and is
  enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/first_paragraph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/first_paragraph -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en first_paragraph -y
```

Enabling the module makes the **First Paragraph** formatter available; it does not
change any display until you select it on a field.

## Verify it worked

Go to a content type's **Manage display** (for example **Structure → Content types →
Article → Manage display**), switch to the **Teaser** display, and open the
**Format** dropdown for your body field. You should see **First Paragraph** as an
option. Select it, save, and view a teaser — only the first paragraph should
appear. See the [main guide](../index.md#how-to-use-it) for the full walkthrough.
