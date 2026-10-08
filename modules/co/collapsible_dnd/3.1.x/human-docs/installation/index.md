# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib dependencies and no third-party libraries — it builds on core's
  `tabledrag` behaviour.

## Install with Composer

From the project root:

```bash
composer require drupal/collapsible_dnd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/collapsible_dnd -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en collapsible_dnd -y
```

The collapse/expand behaviour is active immediately on every draggable table,
site-wide, with no required configuration.

## Grant the settings permission (optional)

To let a role open the settings form, give it the **"administer collapsible dnd
settings"** permission at **People → Permissions**
(`/admin/people/permissions`). Administrators have it by default.

## Verify it worked

Open a hierarchical draggable table — for example a menu at
`/admin/structure/menu/manage/main`, or **Manage fields** on a content type. Rows
with children should now show a toggle to collapse and expand their sub-tree.
Next, see [Configuration](../configuration/index.md) if you want to scope where it
runs or add the toolbar controls.
