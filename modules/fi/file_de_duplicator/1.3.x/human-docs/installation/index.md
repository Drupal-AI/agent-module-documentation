# Installation

## Requirements

File De-Duplicator is lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_de_duplicator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_de_duplicator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_de_duplicator -y
```

## Verify it worked

After enabling, visit **People → Permissions** and confirm the module's
de-duplication permission appears — grant it only to a trusted administrator
role. Remember to take a backup before running your first de-duplication pass,
since it rewrites file references across the site.
