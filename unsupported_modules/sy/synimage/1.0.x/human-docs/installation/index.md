# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- A working WYSIWYG editor (CKEditor) on the text format where you want the button,
  since Synimage is an editor plugin.
- No third-party Composer packages, PHP extensions, or external libraries are listed
  as required.

Note that this module is flagged **Unsupported / Obsolete** on drupal.org and is not
covered by the security advisory policy, so confirm it still fits your site before
installing.

## Install with Composer

From the project root:

```bash
composer require drupal/synimage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synimage -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synimage -y
```

## Verify it worked

After enabling, edit a text format at
**Configuration → Content authoring → Text formats and editors** and confirm the
Synimage button is available to drag into the CKEditor toolbar. Once it is in the
toolbar, editors using that format can insert an image that opens in a Colorbox
lightbox.
