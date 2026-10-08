# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this 2.0.x branch is Drupal 11
  only.
- Core's **File** module (`file`), which provides the file fields this formatter
  renders. It is a declared dependency and is enabled by default on most sites.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filelist_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filelist_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filelist_formatter -y
```

## Verify it worked

Go to the **Manage display** tab of any bundle that has a core **file** field (for
example **Structure → Content types → Article → Manage display**). Open the
**Format** dropdown for that field — you should now see a **List** option. Select
it, save the display, and view a piece of content with attached files: they should
render as a bulleted or numbered list.

There is no configuration page to visit — all setup happens on the field's display,
described in the [overview](../index.md#how-to-use-it).
