# Installation

## Requirements

- **Drupal 8.8.3, 9, 10, or 11** (`core_version_requirement: ^8.8.3||^9||^10||^11`).
- The **Feeds** module (`feeds:feeds`) enabled — this fetcher plugs into it.
- Core's **File** module (`drupal:file`) enabled — the pasted source is saved as a
  file on the filesystem.

## Install with Composer

From the project root:

```bash
composer require drupal/feedstextareafetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will bring in Feeds if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feedstextareafetcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feedstextareafetcher -y
```

This also enables Feeds and the core File module if they aren't on yet.

## Verify it worked

Go to **Structure → Feed types** (`/admin/structure/feeds`) and add or edit a Feed
type. The textarea fetcher should now appear in the **Fetcher** list. Choose it,
then create a feed of that type — you should get a text box to paste your source
into.
