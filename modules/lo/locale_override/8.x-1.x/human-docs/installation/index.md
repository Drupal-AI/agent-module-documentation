# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Configuration Translation** module (`config_translation`).
- The **Webform** module (`drupal/webform`).

Both dependencies are pulled in and enabled automatically when you install Locale
Override with Composer and the `-W` flag. There are no other third‑party Composer
or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/locale_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the required
dependencies (including Webform) and update shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/locale_override -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en locale_override -y
```

This also enables its dependencies (`config_translation` and `webform`) if they
are not already on.

## Verify it worked

Create a string‑override entity through Locale Override, then run
`drush config:export` (or check **Configuration → Development → Configuration
synchronization**). The override should appear as an exportable configuration
item — confirming that your interface‑string overrides are now stored as config
rather than database‑only.
