# Installation

## Requirements

GlobalLink Connect is a plugin, so it needs a few things in place first:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
  That constraint is unusually wide, which means the codebase has been carried
  forward across major versions rather than rewritten.
- The **Translation Management Tool** modules **TMGMT** (`tmgmt`) and **TMGMT File**
  (`tmgmt_file`) — these are hard dependencies.
- The vendor's own PHP library, **`globallink-connect-api-php`**, installed via
  Composer. This is what actually talks to the GlobalLink API.
- A **translations.com / GlobalLink account** with credentials for your project.
  Without one, there is nothing for the plugin to connect to.

## Install with Composer

Always install this module (and its dependencies) with Composer — do not download
it by hand. From the project root:

```bash
composer require drupal/globallink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and update
any shared dependencies as needed. If the vendor library is not pulled in
automatically, add it explicitly:

```bash
composer require translations-com/globallink-connect-api-php -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/globallink -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en globallink -y
```

Drupal will enable `tmgmt` and `tmgmt_file` at the same time because they are
dependencies.

## Verify it worked

Go to **Configuration → Regional and language → Translation Management →
Providers** (`/admin/tmgmt/translators`) and start adding a provider. In the
**Provider plugin** list you should now see **GlobalLink** as an option. If it
appears, the plugin is registered correctly and you can move on to
[Configuration](../configuration/index.md).
