# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- The contributed modules **Finders** (`finders`), **Date Recur** (`date_recur`),
  and **Calendar View** (`calendar_view`). Because Finders itself depends on
  Search API and Views Reference, those come along too. Composer pulls all of these
  in automatically when you require Finders Events below.

## Install with Composer

From the project root:

```bash
composer require drupal/finders_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Finders, Date
Recur, Calendar View, and their dependencies, updating shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/finders_events -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en finders_events -y
```

Drupal enables Finders (and its Search API / Views Reference dependencies), Date
Recur, and Calendar View at the same time if they aren't already on.

## Permissions

The module provides its own permissions. Assign them under **People → Permissions**
(`/admin/people/permissions`) to control who can create and manage event channels.

## Verify it worked

After enabling, an **Events** finder type becomes available when creating a Finder
channel. You'll typically also need a **Search API** index covering your event
content, as Finders builds its lists through Search API. See the
[main guide](../index.md#how-to-use-it) and the base
[Finders guide](../../../../finders/1.0.x/human-docs/index.md) for the overall workflow.
