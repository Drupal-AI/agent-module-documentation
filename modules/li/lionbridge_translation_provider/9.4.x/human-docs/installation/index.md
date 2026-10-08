# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Translation Management Tool** module (`tmgmt`) — install and enable it
  first. Depending on your install path it is not always pulled in automatically
  by this project's info file, so confirm it is present.
- A **Lionbridge Translation Services account** with a **username**, **password**,
  and **API access token**. Contact Lionbridge if you don't have credentials for
  the current service (or have lost legacy ones).

## Install with Composer

Use the **project** name for Composer. From the project root:

```bash
composer require drupal/lionbridge_translation_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lionbridge_translation_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name differs from the project name — enable
**`tmgmt_contentapi`**, not the project name:

```bash
drush en tmgmt_contentapi -y
```

> `drush en lionbridge_translation_provider` **fails** — that's the project name,
> not the module name. Always enable `tmgmt_contentapi`.

Make sure TMGMT itself is enabled too (`drush en tmgmt -y`) if it isn't already.

## Verify it worked

Go to **Configuration → Regional and language → Translation Management
Translators** (`/admin/tmgmt/translators`). You should be able to add a new
translator and pick the **Lionbridge** plugin. Configuring it with your
credentials is the next step — see [Configuration](../configuration/index.md).
