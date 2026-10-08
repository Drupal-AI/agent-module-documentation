# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core modules **Media** (`media`), **Media Library** (`media_library`),
  **CKEditor 5** (`ckeditor5`), **Editor** (`editor`), and **File** (`file`).
  Drupal enables any that are missing when you turn on Media Scene.

There are no external JavaScript libraries, third-party services, or API keys to
configure.

## Install with Composer

From the project root:

```bash
composer require drupal/media_scene -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_scene -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_scene -y
```

## Verify it worked

After enabling, the module does nothing visible until you add its buttons to a text
format's CKEditor 5 toolbar — see [Configuration](../configuration/index.md). Once
that is done, open a field that uses the format and confirm the **Add Background
Image**, **Background Scene Settings**, and **Remove Background Image** buttons
appear in the editor toolbar.
