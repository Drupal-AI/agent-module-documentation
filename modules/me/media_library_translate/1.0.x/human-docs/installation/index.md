# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** (`media`), **Media Library** (`media_library`), and **Content
  Translation** (`content_translation`) modules enabled. Drupal will pull these in
  as dependencies when you enable the module.
- A genuinely multilingual site: more than one language added, and media
  translation enabled (see "How to use it" in the [overview](../index.md)).

No supplementary libraries are required, and there are no PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_translate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_translate -y
```

If Content Translation isn't already on, you can enable it at the same time:

```bash
drush en content_translation -y
```

## Verify it worked

Make sure you have added a second language and enabled translation for your media
types, then enable the **Show translation button** option on a Media reference
field's **Manage form display** (see the [overview](../index.md)). Edit a piece of
content that uses that field, select a media item in the Media Library widget, and
confirm the translate button appears on the selected item and opens the media
translation overview.
