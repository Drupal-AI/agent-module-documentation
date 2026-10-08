# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (always enabled) — the only declared dependency.
- To configure the field through the UI you need the core **Field UI**
  (`field_ui`) module enabled, so that "Manage form display" pages exist. If
  Field UI is off, you can still configure it by editing the form-display config
  in code.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hide_revision_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hide_revision_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hide_revision_field -y
```

On install the module sets its own module weight to 1 so its form alterations run
late (after core), which is required for it to take over the revision log widget.

## Verify it worked

Go to a bundle's **Manage form display** page (for example
`/admin/structure/types/manage/article/form-display`) and open the settings gear
on the **Revision log message** row. If you see options like **Show the revision
log message field** and **Hide the revision tab**, the module is active. See
[Configuration](../configuration/index.md) for what each setting does.
