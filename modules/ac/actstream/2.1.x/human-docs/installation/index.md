# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1** or later.
- For each external service you want to aggregate, whatever that service needs —
  a feed URL, an account, or API credentials — entered per user (see below).

There are no third-party Composer library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/actstream -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/actstream -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en actstream -y
```

Enabling the module creates the `actstream_item` entity type and the accounts
storage table.

## Service submodules — enable the sources you need

Activity Stream itself just holds and displays items; the actual service
integrations ship as optional submodules (Twitter, Instagram search, Last.fm,
Flickr, a Facebook page, a plain RSS/Atom feed, and others). Enable the ones you
want with `drush en`, for example a plain feed source:

```bash
drush en actstream_feed -y
```

Each service submodule requires the base Activity Stream module. After enabling a
service, connect it per user on that user's accounts form at
`/user/{uid}/edit/actstream`, then let cron (or `drush actstream:fetch`) pull in
items. See the [main guide](../index.md#how-to-use-it) for the full flow.
