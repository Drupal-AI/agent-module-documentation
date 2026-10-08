# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** system and a text format with a CKEditor/text editor — both
  standard in Drupal. No modules outside core, and no third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/rel_attributes_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rel_attributes_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rel_attributes_filter -y
```

## Verify it worked

Enabling the module makes the filters *available* but does not turn them on
anywhere yet. Go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), configure a format, and confirm the
Rel Attributes filter options appear under **Enabled filters**. See the "How to
use it" section of the [overview](../index.md) for the per-format steps, then view
a page whose links use that format and inspect an anchor to confirm the expected
`rel` attribute is present.
