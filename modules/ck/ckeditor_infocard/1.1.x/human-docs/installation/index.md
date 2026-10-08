# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_infocard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_infocard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_infocard -y
```

## After enabling

- **Turn the button on per text format.** The InfoCard button does not appear
  until you add it to a CKEditor 5 format's toolbar — see "How to use it" in the
  [overview](../index.md).
- **No permission to grant.** This module defines no permission of its own; who can
  use the button follows from core's existing text‑format permissions on
  **People → Permissions**.

## Verify it worked

Configure a CKEditor 5 text format, add the **InfoCard** button to its toolbar, and
save. Edit content in that format, select some text, and click the button — it
should wrap the selection in an inline InfoCard.
