# Installation

## Requirements

RRF Search sits on top of Drupal's search stack, so it needs a few things in place:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`).
- The **AI** module (2.0+) with its **AI Search** submodule (`ai_search`) enabled —
  this supplies the vector/semantic search side that RRF fuses with keyword results.

There are no extra third‑party Composer libraries or PHP extensions beyond what
Search API and AI Search themselves require.

## Install with Composer

From the project root:

```bash
composer require drupal/rrf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rrf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rrf -y
```

Enable Search API and AI Search first (or let the dependency resolver pull them in),
since RRF Search has nothing to fuse without them.

## Verify it worked

Log in as an administrator and confirm the module appears as enabled at
**Extend** (`/admin/modules`). Because RRF Search works inside the search pipeline
rather than on a page of its own, the real test is running a hybrid search on a
configured Search API index and confirming results combine your vector and keyword
matches into one ranked list.
