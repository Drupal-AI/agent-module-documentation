# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Webform** (`webform`) and **Webform UI** (`webform_ui`) — the forms this
  module exports, and the UI where you configure the export.
- **For SFTP delivery only:** the `phpseclib/phpseclib` PHP Secure Communications
  Library. It is not needed if you only export by email.

## Install with Composer

From the project root:

```bash
composer require drupal/coc_forms_auto_export -W
```

If you plan to use the **SFTP** delivery option, also require the secure
communications library:

```bash
composer require phpseclib/phpseclib
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform, Webform
UI, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/coc_forms_auto_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en coc_forms_auto_export -y
```

## Verify it worked

Open one of your Webforms and go to its **Results → Downloads** tab. You should
see a new **Automatic CSV Export** section on that page. Configuring it is
described in [Configuration](../configuration/index.md).
