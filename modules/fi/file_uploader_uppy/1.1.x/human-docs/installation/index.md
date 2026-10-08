# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **File Uploader** module (`file_uploader`), which supplies the server side.
  Composer installs it automatically as a dependency.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_uploader_uppy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed and pulls in the `file_uploader` framework this module depends on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_uploader_uppy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_uploader_uppy -y
```

Enabling this module also enables its dependency, **File Uploader**, if it isn't
already on.

## Verify it worked

Go to an entity type's **Manage form display** (for example a Media type or content
type with a file field). In the **Widget** column for your file field, you should now
be able to choose **File Uploader by Uppy**. Select it, save, then edit a piece of
content — the file field should present the Uppy drag-and-drop interface instead of
the plain file input. See [Configuration](../configuration/index.md) for the widget
options.
