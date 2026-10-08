# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core modules **Node**, **Taxonomy**, and **Media** enabled — these are the entity
  types the graph traverses.
- No third‑party Composer or PHP library requirements. (The visualization uses the
  vis‑network JavaScript library, which the module loads at runtime from an external
  CDN — `https://unpkg.com/vis-network/…` — so the browser needs internet access to
  that host for the graph to render.)

## Install with Composer

From the project root:

```bash
composer require drupal/content_dependency_graph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_dependency_graph -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_dependency_graph -y
```

## Grant the permission

Both the index and the per‑node graph are gated by a single permission. Grant it to
the roles that should be able to inspect content structure:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Tick **access content dependency graph** for the appropriate roles (typically
   trusted editors).
3. Save permissions.

## Verify it worked

As a user with the permission, go to **Content → Dependency Graph**
(`/admin/content/dependency-graph`). You should see a table of the 100 most recently
changed nodes, each linking to its graph. Open one and confirm the interactive,
color‑coded graph renders. You should also see a **Dependency Graph** tab on any
node's page.
