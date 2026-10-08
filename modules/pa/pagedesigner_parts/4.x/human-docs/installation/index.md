# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`) — install and enable it first; this add‑on depends on it.
- Core's **Menu UI** (`menu_ui`) and the contributed **Menu Force** (`menu_force`)
  module — Composer resolves these as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_parts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner, Menu
Force and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_parts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_parts -y
```

## Verify it worked

After enabling, go to **Content → Add content** and confirm a **`pagedesigner_part`**
content type is available, and that a **Pagedesigner part** block type appears when you
place a block from **Structure → Block layout**. Create a part node, reference it from a
Pagedesigner part block, and place the block to confirm it renders.
