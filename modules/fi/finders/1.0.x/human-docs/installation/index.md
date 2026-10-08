# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Core's **Block** (`block`) and **Views** (`views`) modules — both ship with
  Drupal core.
- The contributed **Search API** (`search_api`) and **Views Reference**
  (`viewsreference`) modules. Composer pulls these in automatically when you
  require Finders below.

## Install with Composer

From the project root:

```bash
composer require drupal/finders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Search API and
Views Reference and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/finders -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en finders -y
```

Drupal enables Block, Views, Search API, and Views Reference at the same time if
they aren't already on.

## Permissions

Finders provides its own permissions. Assign them under **People → Permissions**
(`/admin/people/permissions`) to control who may create and manage Finder channels.

## Verify it worked

After enabling, the **Finder** entity type is available. You will typically also
need a **Search API** server and index set up for the content you want to list. See
the [main guide](../index.md#how-to-use-it) for the overall workflow, and consider
adding a Finder-type module such as **Finders Events** for richer channels.
