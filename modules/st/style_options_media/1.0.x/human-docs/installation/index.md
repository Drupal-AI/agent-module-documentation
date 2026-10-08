# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Media Library Form Element** module
  (`media_library_form_element`) — a hard dependency, which provides the
  Media Library picker this module's style option uses.
- The **Style Options** module, whose system this plugin extends.

## Install with Composer

From the project root:

```bash
composer require drupal/style_options_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Media Library
Form Element dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/style_options_media -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_options_media -y
```

## Verify it worked

There is no settings form. After enabling, the new media style-option plugin is
available within the Style Options system — configure a component's style options
in the usual Style Options way and confirm you can now choose a media item from the
Media Library.
