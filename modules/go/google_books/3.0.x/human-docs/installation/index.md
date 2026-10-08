# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Editor** module (`editor`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements. A Google Books API
key is **optional** — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/google_books -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_books -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_books -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit one of your formats — you should see a
**Google Books** filter listed among the available filters. Turn it on and save,
then follow [Configuration](../configuration/index.md) to finish the setup and test
it in a piece of content.
