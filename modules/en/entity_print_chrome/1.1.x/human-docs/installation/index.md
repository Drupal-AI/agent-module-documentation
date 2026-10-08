# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Entity Print** module (`entity_print`) — a hard dependency that provides
  the print links, routes, and access control.
- The **`chrome-php/chrome`** PHP library — installed automatically by Composer
  when you require this module.
- A **Chrome or Chromium binary installed on the web server** (for example at
  `/usr/bin/google-chrome`). This is the actual browser the engine drives; it is
  not installed by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_print_chrome -W
```

This pulls in both Entity Print and the `chrome-php/chrome` library. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_print_chrome -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable this module together with Entity Print:

```bash
drush en entity_print entity_print_chrome -y
```

## Provide a Chrome/Chromium binary

Make sure Chrome or Chromium is installed on the server that runs Drupal. Note
the full path to the binary (commonly `/usr/bin/google-chrome` or
`/usr/bin/chromium`) — you will enter it in the engine settings if it differs
from the default.

## Verify it worked

Go to **Configuration → Content authoring → Entity Print**
(`/admin/config/content/entityprint`). The **Chrome** engine should now be
selectable. After you select it and confirm the binary path (see
[Configuration](../configuration/index.md)), generate a PDF from an Entity Print
print link and confirm you get a Chrome‑rendered document with correct CSS.
