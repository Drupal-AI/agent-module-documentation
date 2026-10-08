# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** (`field`) and **File** (`file`) modules — both part of the
  standard install.

No special PHP extensions are required. The GifPlayer jQuery library used for
playback ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/gifplayer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gifplayer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gifplayer -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field** and
confirm **GIF Player** appears as a field type. Add it, set the GIF Player
formatter on **Manage display**, upload a GIF to a piece of content, and check that
it shows paused on the page and animates when you click it.
