# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- No contributed module dependencies, third‑party Composer packages, or PHP
  extensions are required. (Views integration uses core's Views module, which is
  part of standard Drupal installs.)

## Install with Composer

From the project root:

```bash
composer require drupal/entityqueue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entityqueue -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityqueue -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entityqueue Smartqueue** | `entityqueue_smartqueue` | Adds a *Smartqueue* handler that automatically creates a subqueue per entity of a chosen type — e.g. a dedicated related-content or cross-sell queue for each taxonomy term or product. Enable it only if you need that per-entity behavior. |

To enable it:

```bash
drush en entityqueue_smartqueue -y
```

## Verify it worked

Log in as an administrator and visit **Structure → Entityqueues**
(`/admin/structure/entityqueue`). If the queues listing page loads with an **Add
entity queue** button, the module is ready. Continue to
[Configuration](../configuration/index.md) to create your first queue.
