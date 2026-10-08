# Installation

## Requirements

- **Drupal 10.3 or higher, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or higher.**
- Core **Taxonomy** module (`taxonomy`) — ships with Drupal and is enabled
  automatically as a dependency.

No additional contributed modules are required. Taxonaut bundles the SortableJS
library (MIT‑licensed) for its drag‑and‑drop inside the module, so there is no
external JavaScript library to download or install. It works with the Claro
(core) and Gin admin themes.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonaut -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonaut -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonaut -y
```

There is no configuration step — the tree view is available as soon as the
module is enabled.

## Set permissions

Every Taxonaut operation requires the core **Administer taxonomy** permission.
For more granular control, assign the per‑vocabulary *"Taxonaut: Manage terms in
{vocabulary name}"* permissions at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`). Each vocabulary
should now show a **Tree View** link in its operations dropdown, and opening a
vocabulary's term list should show a new **Tree View** tab. Open it and you
should see the interactive tree.
