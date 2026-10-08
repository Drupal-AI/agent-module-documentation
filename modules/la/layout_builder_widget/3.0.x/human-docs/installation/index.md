# Installation

## Requirements

Layout Builder Widget extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements. To get the full
"Layout as a Field" experience you may also want the separate **Layout Builder
Formatter** module, which handles positioning the layout output on *Manage display* —
but it is not required to use the widget.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_widget -y
```

## Verify it worked

Go to **Manage form display** for a content type that uses Layout Builder (for
example `admin/structure/types/manage/article/form-display`), set the **Layout**
field's widget to **Layout Builder Widget**, and save. Then edit or create a node of
that type — the Layout Builder interface should appear directly on the edit form
instead of behind a separate *Layout* tab.
