# Installation

## Requirements

- **Drupal 8, 9, 10, 11 or 12**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- No other contrib modules or third-party libraries are required.

> **Security coverage:** this module is **not** covered by the Drupal security
> advisory policy. Combined with the upload behaviour described below, that is a
> reason to be cautious about where you deploy it.

## Install with Composer

From the project root:

```bash
composer require drupal/textarea_file_drag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/textarea_file_drag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en textarea_file_drag -y
```

## After enabling

Two steps make the feature usable and safe:

1. **Assign the permission carefully.** On **People → Permissions**, grant
   `dragndrop files to textarea` only to trusted roles — it enables both the drop
   zone and the upload endpoint.
2. **Review the settings.** Open
   **Configuration → Media → Textarea File Drag'n'Drop** and tighten the allowed
   extensions and upload path before anyone uses it. See
   [Configuration](../configuration/index.md).
