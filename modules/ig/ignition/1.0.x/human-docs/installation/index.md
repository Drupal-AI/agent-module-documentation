# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- This is a **development-only** module. Install it on local and staging
  environments, not on production.

The `spatie/ignition` PHP package it wraps is pulled in automatically by Composer,
so there is nothing to download by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/ignition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ignition -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ignition -y
```

Then clear the cache so the new error handler takes effect:

```bash
drush cr
```

## Turn on verbose error display

Ignition only renders when Drupal is configured to show errors verbosely. Go to
**Configuration → Development → Logging and errors**
(`/admin/config/development/logging`) and set **Error messages to display** to
**All messages, with backtrace information**. On a local development site this is
the right setting; on production it must stay **None**.

See [Configuration](../configuration/index.md) for how to lock production down in
`settings.php` and for the `view ignition error page` permission.

## Verify it worked

On your development site, trigger an error (for example, visit a page in a module
you are actively debugging). Instead of Drupal's default error output you should
see the Ignition screen with a readable stack trace, the failing line highlighted,
and any matching suggested solutions. If you still see Drupal's plain page, confirm
the error level is verbose, the cache has been cleared, and your user holds the
`view ignition error page` permission.
