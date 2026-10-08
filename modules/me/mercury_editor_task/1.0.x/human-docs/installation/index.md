# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The [**Mercury Editor**](https://www.drupal.org/project/mercury_editor) module —
  a required dependency; this module adds a dedicated task around it.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mercury_editor_task -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Mercury Editor is not already installed, require it too:

```bash
composer require drupal/mercury_editor -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mercury_editor_task -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mercury_editor_task -y
```

On install, the module sets up a **Mercury Editor** form display mode and enables it
for the content types that use Mercury Editor. After enabling, visit the settings
form to tune the task — see [Configuration](../configuration/index.md).

## Verify it worked

Open a node whose content type uses Mercury Editor. You should see a **Mercury
Editor** tab beside the usual View/Edit tabs (and the same option in the node's
operations list). Clicking it opens the node at `/node/{node}/mercury-editor` in the
Mercury Editor page‑building interface.
