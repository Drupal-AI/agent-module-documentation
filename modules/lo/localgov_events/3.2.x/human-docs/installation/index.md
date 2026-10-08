# Installation

## Requirements

LocalGov Events builds on a mix of core and contrib modules. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules: **Link**, **Path**, **Taxonomy**, and **Views**.
- Contrib modules, all pulled in by Composer:
  - **Date Recur** (`date_recur`) — the recurring-date field.
  - **Date Recur Modular** (`date_recur_modular`) — the friendly recurrence widget.
  - **Facets** (`facets`) — the category filtering on the listing.

There are no extra third-party PHP library requirements. It's designed for a LocalGov Drupal
site but the events functionality works on a standard Drupal site with those dependencies
present.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Date Recur, Date Recur
Modular, and Facets dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_events -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_events -y
drush cr
```

Enabling the module creates the **Event** content type, its fields, the listing and search
views, and the category facets — so it's ready to use immediately. Head to **Content → Add
content → Event** to create your first event (see the
[overview](../index.md#how-to-use-it)).

## Submodule — automatic clean-up of finished events

To have events archived or removed after they finish, enable the optional submodule:

```bash
drush en localgov_events_remove_expired -y
```

It adds a settings page at **Configuration → Content authoring → Expired events**
(`/admin/config/content/expired-events`) where you control what happens to events once they're
over. It requires the base LocalGov Events module, which is already present once you've
installed it above.

## A note on directory venues

If you also run the LocalGov Directories page or venue modules, LocalGov Events wires up
optional configuration so events can reference a directory venue. This happens automatically
when those modules are installed — except during a configuration import (config sync), where
you may need to re-run the optional config install manually afterward. See the sibling
[`agent/`](../../agent/start.md) docs for the exact command if you hit that case.
