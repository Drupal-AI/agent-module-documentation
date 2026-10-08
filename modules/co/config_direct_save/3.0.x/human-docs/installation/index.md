# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Configuration Manager** module (`config`), which provides the
  Synchronize screen this module attaches to and the **Export configuration**
  permission it uses. Configuration Manager is part of the standard install
  profile and enabled on most sites.

There are no third‑party Composer or PHP library requirements, and no
dependencies on other contrib modules.

## Install with Composer

From the project root:

```bash
composer require drupal/config_direct_save -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_direct_save -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_direct_save -y
```

## Grant access

Access to the Update form is controlled by core's **Export configuration**
permission. At **People → Permissions** (`/admin/people/permissions`), grant it
to any role that should be able to run the export, then hand those users the URL
`/admin/config/development/configuration/full/update`.

Make sure your web server user can write to the configuration sync directory (and
create backup subdirectories in it) — otherwise the export will fail. There is no
configuration page to visit; the module works entirely through that one Update
form.
