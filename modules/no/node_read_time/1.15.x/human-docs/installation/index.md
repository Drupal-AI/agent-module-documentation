# Installation

## Requirements

Node Read Time is deliberately lightweight:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third-party Composer libraries and no other contrib module dependencies.

Optional: if your content uses **Paragraphs** (or other entity-reference-revisions
fields), the word count automatically recurses into them — but you don't need
Paragraphs installed for the module to work.

## Install with Composer

From the project root:

```bash
composer require drupal/node_read_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_read_time -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_read_time -y
```

After enabling, head to **Configuration → Reading time**
(`/admin/config/reading-time`) to choose which content types get a reading time
and how it's formatted — see [Configuration](../configuration/index.md).
