# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Core's **JSON:API** (`jsonapi`) module.
- The contributed **JSON:API Extras** module (`jsonapi_extras`), whose serializer
  produces the preview output.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_preview_tab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including JSON:API Extras — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_preview_tab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_preview_tab -y
```

Drupal enables JSON:API and JSON:API Extras as dependencies if they are not already
on.

## Grant the permission

The tab is hidden until you grant **`access jsonapi preview tab`**. At **People →
Permissions** (`/admin/people/permissions`), grant it to **trusted developer
roles only**.

## Verify it worked

Log in as a user with the permission and open a node, media item, taxonomy term, or
menu link. Confirm a **JSON:API Preview** tab appears and that clicking it shows the
entity's serialized, syntax-highlighted JSON along with a link to the live JSON:API
URL.
