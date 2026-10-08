# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1** or newer.
- Two Symfony libraries, which Composer installs for you: **symfony/dom-crawler**
  (to parse the HTML) and **symfony/css-selector** (to match the `<style>` tags).

Because of the Symfony library requirements, install this module with Composer
rather than by copying files.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_style_aggregation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`symfony/dom-crawler` and `symfony/css-selector` libraries and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_style_aggregation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_style_aggregation -y
```

## Grant the permission

Go to **People → Permissions** and grant **Administer inline style aggregation**
to the roles that should be able to change these settings. It is a restricted
permission — keep it to trusted administrators.

## Verify it worked

Go to **Configuration → Development → Performance → Inline Style Aggregation**
(`/admin/config/development/performance/inline-style-aggregation`), turn on the
master **Enable** switch, and save (see [Configuration](../configuration/index.md)).
Then load a page that has inline `<style>` blocks and view its source: you should
find the scattered inline styles gone from the body and a single
`<style data-generated-by="inline_style_aggregation">` in the `<head>`.
