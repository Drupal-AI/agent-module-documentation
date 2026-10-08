# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** (`media`), **Media Library** (`media_library`), and **Block
  Content** (`block_content`) modules — Drupal enables these automatically as
  dependencies.
- A **Frontify account** with API access, so you can generate the credentials the
  module needs (see [Configuration](../configuration/index.md)).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/frontify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontify -y
```

Drupal will enable the Media, Media Library, and Block Content dependencies at the
same time.

## Submodules

- **Frontify Colorbox** (`frontify_colorbox`) — adds lightbox (Colorbox) display for
  Frontify assets. Enable it only if you want that display behaviour:

  ```bash
  drush en frontify_colorbox -y
  ```

## Verify it worked

Log in as an administrator and open the Frontify settings page under
**Configuration → Media**. Once you have entered your Frontify credentials there
(see [Configuration](../configuration/index.md)), the **Frontify Finder** becomes
available in your configured media/image fields and WYSIWYG editors.
