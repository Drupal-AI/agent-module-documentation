# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core **Node** (`node`), **Taxonomy** (`taxonomy`), and **Views** (`views`)
  modules, plus core Filter, Path, and Block — Drupal enables the required ones
  automatically as dependencies.
- Historically G2 also expects the **XML‑RPC** feature. XML‑RPC was removed from
  Drupal core and is now a contrib module; only enable its server if you actually
  need it (see the security note on the [overview page](../index.md)).

This is a **beta** release (`8.x-1.0-beta3`) — review it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/g2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/g2 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en g2 -y
```

## Verify it worked

Set the G2 permissions at **People → Permissions**, then create your first
glossary entry as a G2 node. Confirm the entry appears in the alphabetical
browsing View, and place the **Word of the Day** block via **Structure → Block
layout** to check the blocks render.
