# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies.

There are no third-party Composer or PHP library requirements.

> **Important compatibility note:** this module **does not work together with
> core's BigPipe module enabled**. If your site relies on BigPipe, do not use
> Gzip Html output.

## Install with Composer

From the project root:

```bash
composer require drupal/gzip_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gzip_html -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gzip_html -y
```

Enabling the module alone does not start compressing pages — you also need to
turn the setting on, see [Configuration](../configuration/index.md).

## Verify it worked

After enabling the module and turning compression on in the Performance settings,
request a page and check its response headers for `Content-Encoding: gzip` (your
browser's developer tools, Network tab, or `curl -I -H 'Accept-Encoding: gzip'
https://your-site/` will show it). If the header is present, the HTML is being
gzip-compressed.
