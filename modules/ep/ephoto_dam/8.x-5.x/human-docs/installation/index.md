# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **CKEditor 5** (`ckeditor5`) — a dependency, enabled automatically with the
  module. (Core System is also required.)
- An **Ephoto DAM server** you can reach, so you have its URL to connect to.
- No third‑party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/ephoto_dam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ephoto_dam -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ephoto_dam -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Ephoto DAM Field** | `ephoto_dam_field` | A field type for attaching Ephoto assets to entities as structured field data, rather than only embedding them inline through CKEditor 5. |

Enable it if you want the field:

```bash
drush en ephoto_dam_field -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) and enter your
Ephoto DAM **Server URL**. Then add the Ephoto DAM button to a text format's
CKEditor 5 toolbar and confirm that, while editing content, you can search your
Ephoto library and insert an asset.
