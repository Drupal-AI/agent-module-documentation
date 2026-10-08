# Installation

## Requirements

- **Drupal 10.3, 11.0, or 12** (`core_version_requirement: ^10.3 || ^11.0 || ^12`).
- The **FillPDF** module (`fillpdf`) — a hard dependency. FillPDF also needs its own
  PDF‑processing backend configured; see FillPDF's documentation.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root, require FillPDF and this module together:

```bash
composer require drupal/fillpdf drupal/fillpdf_comprehensive_mapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fillpdf_comprehensive_mapper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en fillpdf fillpdf_comprehensive_mapper -y
```

## Before you configure — back up

Selecting a master form will **overwrite the field mappings on all your other
FillPDF forms**. Back up your site configuration first (for example
`drush config:export`) so you can recover if the propagation isn't what you
expected.

## Verify it worked

Log in as a user with the **Administer PDFs** permission and visit
**`/admin/config/media/fillpdf/comprehensive-mapper`**. If the settings form loads
and lists your FillPDF forms to choose from, the module is installed. Continue to
[Configuration](../configuration/index.md) to select the master form.
