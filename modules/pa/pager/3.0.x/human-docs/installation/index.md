# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A number of core modules, which Drupal enables as dependencies: **Block**, **Filter**,
  **Node**, **System**, **Taxonomy**, **Text** and **User**. This relatively wide list
  reflects that Pager can derive its sequence from several different orderings (creation
  date, taxonomy, and so on) rather than only from one.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pager -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pager -y
```

## Optional: Views integration sub‑modules

Alongside the main module, the project ships two optional sub‑modules (currently in a
beta release) for people who want Views‑driven sequences:

| Sub‑module | What it adds |
|------------|--------------|
| **Pager Views** | Implements Pager's previous/next functionality, but integrated with the **Views** module. |
| **Pager Views Example** | A ready‑made example — a view, content type, node display and image style — to help developers and site builders see quickly whether the approach fits their use case. Try it on a development instance (pairs well with Devel Generate for sample content). |

Enable whichever you need with `drush en`, for example:

```bash
drush en pager_views -y
```

## Verify it worked

After enabling, go to **Structure → Block layout**, place the **Pager** block in a
region, and configure it (see [Configuration](../configuration/index.md)). View a piece of
content included in the sequence and confirm the previous/next links appear and point at
the neighbouring items.
