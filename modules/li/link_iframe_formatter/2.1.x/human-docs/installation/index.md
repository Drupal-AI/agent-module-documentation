# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** field module (`link`), which ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

> **Which version?** The 2.x series is the recommended line. There are no breaking
> changes between the old `8.x-1.x` series and 2.x — the project simply moved to
> semantic versioning.

## Install with Composer

From the project root:

```bash
composer require drupal/link_iframe_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_iframe_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_iframe_formatter -y
```

## Verify it worked

Go to **Manage display** for an entity that has a link field, open the **Format**
select list for that field, and confirm **Iframe** appears as an option. Select
it, set a width and height, save, and view content that has a URL in the field —
the target page should render inline as an embedded frame. Review the embedding
safeguards in the [overview](../index.md) before exposing this on a live site.
