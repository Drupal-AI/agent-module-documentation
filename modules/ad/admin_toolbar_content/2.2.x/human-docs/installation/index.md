# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Admin Toolbar** (`admin_toolbar`) **and Admin Toolbar Tools**
  (`admin_toolbar_tools`) — both are required. This module builds on the expanded
  menus that the Tools submodule provides, so a site running only the base Admin
  Toolbar module needs both enabled. Composer pulls the Admin Toolbar project in for
  you.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Admin Toolbar project this module depends on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable this module together with the two Admin Toolbar modules it needs:

```bash
drush en admin_toolbar admin_toolbar_tools admin_toolbar_content -y
```

Drupal will refuse to enable `admin_toolbar_content` unless both `admin_toolbar` and
`admin_toolbar_tools` are present, so enabling all three together is the simplest
approach.

## After enabling

Hover over the content area of the Admin Toolbar to see the new per‑type entries. To
tune which entries appear, visit **Configuration → User interface → Admin Toolbar
Content** (`/admin/config/user-interface/admin-toolbar-content`).
