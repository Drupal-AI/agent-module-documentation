# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`).
- The **Flexible Permissions** module (`flexible_permissions`) — Group Features
  builds on it to structure what each group type offers.

## Install with Composer

From the project root:

```bash
composer require drupal/group_features -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Flexible Permissions) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_features -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_features -y
```

Drupal enables the Group and Flexible Permissions dependencies automatically if
they aren't already on.

## Grant permissions

This module provides the **Administer group_feature** permission. Grant it to the
roles that should manage per‑group features at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Open a group type's **Features** screen at
`/admin/group/types/manage/{group_type}/features` and confirm you can define
features and toggle them on individual groups. When a feature is enabled for a
group, its bundled permissions should apply to that group.
