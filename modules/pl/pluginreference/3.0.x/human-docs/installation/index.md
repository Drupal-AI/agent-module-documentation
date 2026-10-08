# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 ||
  ^11`; the Composer requirement pins `drupal/core: ^10.3 || ^11`).
- Core's **Field** module (`field`) — Drupal enables it automatically as a
  dependency, and it is enabled on virtually every site already.

There are no third‑party Composer or PHP library requirements beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/pluginreference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pluginreference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pluginreference -y
```

## Grant access

The autocomplete endpoint that backs the field is protected by the
**`pluginreference autocomplete view results`** permission, which is deliberately
access‑restricted because it enumerates the plugins available on the site. At
**People → Permissions** (`/admin/people/permissions`), grant it only to roles you
trust to use the plugin picker.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click
**Add field**. If **Plugin reference** appears in the list of available field
types, the module is installed and ready to use.
