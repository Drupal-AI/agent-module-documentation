# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) with **PHP 8.0 or higher**.
- Core's **File** (`file`), **Media** (`media`), and **CKEditor 5** (`ckeditor5`)
  modules — Drupal enables these automatically as dependencies. CKEditor 5 is what
  provides the Hivo embed button in the editor.
- A **Hivo account**. For CDN embedding, that account must have **CDN embedding
  enabled**.

## Install with Composer

From the project root:

```bash
composer require drupal/hivo_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hivo_connector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hivo_connector -y
```

## Verify it worked

Go to **Administration → Hivo Connector** (`/admin/hivo-connector`). You should
see the page where you log in with your Hivo account. Once connected, continue
with [Configuration](../configuration/index.md) to add the embed button and
review credential storage.
