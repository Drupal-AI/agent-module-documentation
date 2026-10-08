# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) — a dependency Drupal enables automatically.
- No third‑party Composer packages or PHP libraries.

## Install with Composer

The Composer package name is `drupal/erfo` (the `erfo` project), which differs
from the module's machine name. From the project root:

```bash
composer require drupal/erfo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/erfo -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `entity_reference_field_override` even though the
package is `erfo`:

```bash
drush en entity_reference_field_override -y
```

## Grant permissions

This module provides its own permissions. Go to **People → Permissions**
(`/admin/people/permissions`) and grant the override capability to the roles
that should be allowed to set per-instance overrides.

## Verify it worked

With the module enabled and permissions granted, editing a reference to a shared
entity should let you set local, per-instance field overrides that leave the
original entity unchanged. Confirm the overridden value shows only in that
placement and that the source entity is unaffected elsewhere.
