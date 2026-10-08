# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Locale** module (`locale`) and **Path Alias** module (`path_alias`) —
  both are dependencies and Drupal enables them automatically.
- A multilingual site with **more than one language** configured under
  **Configuration → Regional and language → Languages**, and — importantly — a
  **URL prefix set for each enabled language** so that the language‑specific pages
  are directly reachable.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/language_selection_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_selection_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_selection_page -y
```

Enabling the module does **not** immediately change your site — the selection page
only appears once you enable and position its negotiation method. See
[Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`), then open
**Configuration → Regional and language → Languages → Detection and selection**
(`/admin/config/regional/language/detection`). You should now see **Selection
Page** listed among the interface language detection methods. Once you enable and
position it (Configuration), visit the site as a fresh visitor with no language
cookie or prefix and you should be shown the language chooser.
