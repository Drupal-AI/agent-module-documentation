# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Sector Table of Contents** module (`sector_toc`) — a hard dependency.
- For full functionality it also expects the **Sector distribution** and the
  **Chunker** module, which splits a long HTML document into the sections that
  Multipage then pages through.

There are no third-party PHP or library requirements, and there are no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_multipage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Sector Table of
Contents and update any shared dependencies as needed. You will also need the
**Chunker** module and, for the intended experience, the Sector distribution.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_multipage -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_multipage -y
```

Enabling it will also enable Sector Table of Contents if it is not already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. You should see the **Sector Multipage Pagination** and **Sector Multipage
Actions** blocks available. Remember that the pagination block must be placed on
your long-document content type's default display for the paging behavior to load —
see the [main guide](../index.md).
