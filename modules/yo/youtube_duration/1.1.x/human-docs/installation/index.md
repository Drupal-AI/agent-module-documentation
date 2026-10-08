# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`).
- The **[Duration Field](https://www.drupal.org/project/duration_field)** module
  (`duration_field` `^2.0`) — pulled in automatically by Composer. It provides the
  Duration field type this module populates.
- A **media type whose source is oEmbed (Video)** with a **Duration** field added to
  it.
- A **YouTube Data API v3 key** from the Google Cloud console (with the "YouTube Data
  API v3" enabled).

## Install with Composer

From the project root:

```bash
composer require drupal/youtube_duration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Duration Field
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/youtube_duration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en youtube_duration -y
```

There are no submodules and no settings page. Configuration lives on the media type's
edit form — see [the overview](../index.md#how-to-use-it) for the step-by-step.
