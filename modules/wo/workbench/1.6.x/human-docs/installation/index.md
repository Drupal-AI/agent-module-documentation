# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core modules it builds on, all enabled automatically as dependencies:
  **Image**, **Node**, **Toolbar**, **User**, and **Views**.

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/workbench -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/workbench -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workbench -y
```

## Grant permissions to editors

Workbench only appears for users who have the right permissions. At a minimum,
give your editor role **Access My Workbench**, and keep **Administer Workbench
content settings** for administrators. A typical setup:

```bash
drush role:perm:add editor 'access workbench'
drush role:perm:add editor 'access toolbar'
drush role:perm:add editor 'create article content'
drush role:perm:add editor 'edit own article content'
```

Once an editor with `access workbench` logs in, the **Workbench** toolbar tab
appears and links to their `/admin/workbench` dashboard. See the
[overview page](../index.md) for how to reshape the dashboard regions.
