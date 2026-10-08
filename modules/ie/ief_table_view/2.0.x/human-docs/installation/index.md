# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **Views** module (`views`) — enabled on most sites, and pulled in as a
  dependency.
- The **Inline Entity Form** module (`inline_entity_form`) — the required
  contrib dependency this module integrates with.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ief_table_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Inline Entity Form if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ief_table_view -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ief_table_view -y
```

Drupal enables the required Views and Inline Entity Form modules automatically as
dependencies.

## Verify it worked

Build a View of your referenced entity type, point an Inline Entity Form widget's
table at it on the host type's **Manage form display**, then edit a piece of
content — the inline table should render with the columns from your View instead
of IEF's default set.
