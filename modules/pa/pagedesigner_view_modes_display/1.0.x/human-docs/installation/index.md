# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`) — install and enable it first; this add‑on depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_view_modes_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_view_modes_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_view_modes_display -y
```

## After installation

1. Configure the module settings at
   **`/admin/config/pagedesigner-view-modes-display/settings`**.
2. Grant this module's permission to the appropriate roles at **People → Permissions**.
3. Open a page in Pagedesigner and, for each element, select the view modes in which it
   should be hidden.

## Verify it worked

Hide an element in one view mode, then view the content in that view mode and in another —
the element should be absent from the first and present in the second.
