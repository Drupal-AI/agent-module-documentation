# Installation

## Requirements

Regex Text Replacement needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) enabled — the only dependency, and part of a
  standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/regex_text_replacement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/regex_text_replacement -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en regex_text_replacement -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit any text format. In the **Enabled
filters** list you should now see **Regex Text Replacement**. See
[Configuration](../configuration/index.md) for how to enable and set it up on a
format.
