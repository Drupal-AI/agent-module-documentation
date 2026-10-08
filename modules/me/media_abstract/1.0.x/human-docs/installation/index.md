# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File** module (`file`) and **Media** module (`media`) — enabled automatically as
  dependencies. You will also want the media types (image, video, document, …) you intend
  the field to accept set up in the usual way.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_abstract -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_abstract -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_abstract -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click **Add field**.
**Media abstract file** should appear in the list of field types. Add it, enable a couple of
media types in its settings, then edit content and upload a file — a media entity of the
matching type should be created automatically on save. Setting up and using the field is
covered in "How to use it" in the [overview](../index.md).
