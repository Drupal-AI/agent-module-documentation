# Installation

## Requirements

Plupload file widget needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Plupload** module (`drupal/plupload` `^2.1`) — pulled in automatically by
  Composer. Plupload wraps the Plupload JavaScript upload library.

There are no additional PHP library requirements from this module. Note that
effective upload sizes are governed by your server's PHP settings
(`upload_max_filesize`, `post_max_size`).

## Install with Composer

From the project root:

```bash
composer require drupal/plupload_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Plupload** module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plupload_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plupload_widget -y
```

That enables the widget module and, if it isn't already on, the **Plupload**
dependency. There's no configuration step — switch a File or Image field's widget
over on *Manage form display* as described in
[How to use it](../index.md#how-to-use-it).
