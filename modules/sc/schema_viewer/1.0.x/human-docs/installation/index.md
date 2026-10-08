# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **System** module (`system`) — always present on a Drupal site, so there
  is nothing extra to install.

There are no PHP‑library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_viewer -W
```

The Composer package name (`drupal/schema_viewer`) matches the module's machine
name (`schema_viewer`). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_viewer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_viewer -y
```

That is all it takes — there is no configuration form.

## Grant access

Because the tool exposes internal database structure, decide who may use it. Go to
**People → Permissions** (`/admin/people/permissions`) and grant the **Access
Schema Viewer** permission to the roles that should have it — typically
administrators or developers. Keep it away from untrusted roles.

## Verify it worked

Go to **Configuration → Development → Schema Viewer**
(`/admin/config/development/schema-viewer`). Type a known table name such as `node`
into the autocomplete field, select it, and confirm the page lists that table's
fields, types, sizes, constraints, and indexes.
