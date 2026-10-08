# Installation

## Requirements

- **Drupal 8.9 through 12** (`core_version_requirement:
  ^8.9 || ^9 || ^10 || ^11 || ^12`).
- Core's **Link** field module (`link`), which ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

> **Do you actually need this?** The core bug this module works around was fixed
> in **Drupal 10.2.3**. On that version or newer you can usually rely on core's
> own Link formatter instead.

## Install with Composer

From the project root:

```bash
composer require drupal/link_formatter_query_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_formatter_query_fix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_formatter_query_fix -y
drush cr
```

Rebuilding the cache makes the new formatter available in the display settings.

## Verify it worked

Go to **Manage display** for an entity with a link field, open the **Format**
select list for that field, and confirm **Link (query duplication fix)** appears
as an option. Select it, save, and view content — a link with a query string
should render without the parameters being duplicated.
