# Installation

Content Porter must be installed on **both** the source site (where you export) and
the destination site (where you import). Do the following on each.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`) — enabled automatically as a
  dependency.
- On the **destination** site, the content structure must already match the source:
  the same content types, field machine names and types, paragraph types, media
  types, taxonomy vocabularies, and custom block types. Content Porter imports data
  into existing structure; it does not create it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

Note that the Composer package name (`drupal/content_migration_porter`) differs
from the module's machine name (`content_porter`). Install with the package name:

```bash
composer require drupal/content_migration_porter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_migration_porter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `content_porter` (not the project name):

```bash
drush en content_porter -y
```

## Verify it worked

Log in as a user with **Administer site configuration**. You should be able to
reach **Export content** at `/admin/content-export` and **Import content** at
`/admin/content-import`. Do this on both sites — export on the source, import on the
destination. See the [overview](../index.md) for the full export/import flow.
