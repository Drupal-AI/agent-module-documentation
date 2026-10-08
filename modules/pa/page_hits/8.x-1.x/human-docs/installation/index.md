# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No contributed module dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/page_hits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_hits -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_hits -y
```

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the count to appear.
3. Search for the **Page Hits** block, place it, and configure its visibility (for
   example, restrict it to specific pages or content types).
4. Save the block.

## Verify it worked

Visit a page where the block is placed as a visitor, then reload it — the hit
count should appear and increase as the page is viewed. For finer control over
tracking and display, open **Configuration → System → Page Hits**, described in
[Configuration](../configuration/index.md).
