# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The [Gutenberg](https://www.drupal.org/project/gutenberg) editor module,
  **version 2.x or newer** — this is a hard dependency (`gutenberg:gutenberg`)
  and provides the editor the blocks plug into.
- A front-end theme based on **Bootstrap 4.5 or newer**, so the container/row/
  column markup renders as an actual responsive grid.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_bs_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Gutenberg and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gutenberg_bs_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_bs_blocks -y
```

Enabling it will also enable the Gutenberg module if it is not already on.

## Verify it worked

Edit a piece of content on a content type where the Gutenberg experience is
active. Open the block inserter in the editor and search for **Container**,
**Row**, and **Column** — the three new Bootstrap grid blocks should appear.
Insert a container, add a row, and drop a couple of columns inside it to confirm
the grid renders on the rendered page.
