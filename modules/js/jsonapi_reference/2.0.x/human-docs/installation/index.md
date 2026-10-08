# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer** — the recommended **2.0.x** branch requires it. If you
  cannot run PHP 8.1 yet, the older `8.x-1.0` branch exists, but new features go to
  2.0.x.
- A reachable **external JSON:API endpoint** to reference, using HTTP basic
  authentication.

There are no additional contributed-module dependencies.

> **Upgrading from 8.x-1.x?** The 2.0.x alpha changes the shape of the
> `JsonApiClient::search()` response, which breaks compatibility with 8.x-1.0, so
> custom code that consumes it may need changes.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_reference -y
```

## Verify it worked

After configuring a JSON:API source (see [Configuration](../configuration/index.md))
and adding a **Typed Resource Object** field to a content type, edit a piece of
content and start typing in that field. The autocomplete widget should query the
remote system and suggest matching remote resources. Saved, the reference stores the
remote resource object's GUID (which, absent a field formatter, is what displays by
default).
