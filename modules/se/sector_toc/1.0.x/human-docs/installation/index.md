# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** module (`block`).
- The **Chunker** module (`chunker`) — a hard dependency used when working with
  long documents split into sections.

There are no third-party PHP or library requirements, and there are no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_toc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Chunker and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_toc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_toc -y
```

Enabling it will also enable Block and Chunker if they are not already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. You should see a **Table of Contents** block available to place in a
sidebar. Place it, then open a long node whose body has `h2`/`h3` headings and
confirm the contents list appears and highlights the active heading as you scroll —
see the [main guide](../index.md).
