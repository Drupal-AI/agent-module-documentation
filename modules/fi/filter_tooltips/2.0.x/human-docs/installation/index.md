# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Taxonomy** and **Filter** modules — both ship with Drupal core. The
  module declares no additional contrib dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_tooltips -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_tooltips -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_tooltips -y
```

Enabling the module makes the **Display tooltips in text** filter available to add
to your text formats; it does not change any content until you turn the filter on.

## Verify it worked

First create a vocabulary with at least one term that has both a name and a
description. Then go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), configure a format, and confirm
**Display tooltips in text** appears in the **Enabled filters** list. Tick it,
choose your source vocabulary, save, and view content that mentions the term — you
should get a tooltip on hover or click. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough.
