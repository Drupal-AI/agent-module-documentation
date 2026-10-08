# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) and **Taxonomy** (`taxonomy`) modules — both part of
  core, enabled automatically as dependencies. Taxonomy matters because an editor's
  allowed sections are stored in a taxonomy field on their user account.

There are no additional PHP libraries or third‑party Composer requirements. This
project is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/content_access_by_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_access_by_path -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_access_by_path -y
```

## Submodules

The project ships one optional submodule:

- **`content_access_by_path_admin_content`** — extends the behavior to the admin
  content listing. Enable it only if you need it:

  ```bash
  drush en content_access_by_path_admin_content -y
  ```

## Verify it worked

After enabling, configure at least one section and assign it to a test editor via
the taxonomy field on their account (see [Configuration](../configuration/index.md)).
Then log in as that editor and confirm which content they can and cannot edit before
trusting it in production.
