# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) enabled — the only dependency, and Drupal
  enables it automatically. (Field UI is what provides the *Manage fields* screens this
  module hooks into.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_defaults -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_defaults -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_defaults -y
```

After enabling, grant the **Administer field defaults** permission to the roles that
should be allowed to run bulk updates — see [Configuration](../configuration/index.md).
Without that permission, the "Update existing content" section does not appear on field
edit forms.

## Verify it worked

Log in as an administrator and edit any field under **Structure → Content types → (a type)
→ Manage fields → (a field) → Edit**. You should see an **"Update existing content"**
section on the page. The global setting is at **Configuration → System → Field defaults
settings** (`/admin/config/system/field_defaults/settings`).
