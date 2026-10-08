# Installation

## Requirements

File entity needs:

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **File**, **Text**, **Views**, and **Image** modules.
- The contributed **Token** module (`token`), which Composer pulls in.

## Install with Composer

From the project root:

```bash
composer require drupal/file_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Token
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_entity -y
```

Drupal enables the File, Text, Views, Image, and Token dependencies at the same
time.

## Verify it worked

Visit **Structure → File types** (`/admin/structure/file-types`) — you should see
the file-type management screen. The file administration listing at **Content →
Files** (`/admin/content/files`) should also be available. Next, define your file
types and grant permissions in [Configuration](../configuration/index.md).
