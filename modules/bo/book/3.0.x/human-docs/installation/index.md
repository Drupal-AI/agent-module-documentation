# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`). On Drupal 10
  and earlier, Book is part of core and you don't install it separately.
- Core's **Node** module (`node`), which is enabled on any standard Drupal site
  and is pulled in as a dependency.
- The **PDO** PHP extension (`ext-pdo`), which is standard on any Drupal‑capable
  PHP install.

## Install with Composer

From the project root:

```bash
composer require drupal/book -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book -y
```

After enabling, head to [Configuration](../configuration/index.md) to allow at
least one content type to join books — until you do, nothing can be added to an
outline.

## Submodules — enable only what you need

Book ships two optional submodules, both requiring the base module:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Book Olivero** | `book_olivero` | Styling and templates so book navigation looks right in Drupal's Olivero front‑end theme. |
| **Book Content Type** | `book_content_type` | A ready‑made "Book" content type, pre‑configured to participate in books (originates from the project's test fixtures). |

Enable them individually, for example:

```bash
drush en book_olivero -y
```

## A note on uninstalling

You cannot uninstall Book while any book outline still exists — an uninstall
validator blocks it. Remove your books first if you ever need to uninstall.
