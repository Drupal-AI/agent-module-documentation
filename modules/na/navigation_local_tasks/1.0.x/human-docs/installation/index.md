# Installation

> **Heads‑up:** this project is marked **unsupported / obsolete** and is expected
> to be deprecated once the equivalent core work lands. Weigh that before adopting
> it, and prefer the core alternative when it becomes available.

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Navigation** module (`navigation`) — this module adds to the new
  Navigation toolbar and depends on it, so Navigation must be enabled.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation_local_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/navigation_local_tasks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation_local_tasks -y
```

Drupal enables the core Navigation dependency automatically if it is not already
on.

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm the
module's local‑task blocks are available to place into the Navigation toolbar.
After placing and configuring one, open an entity page (a node, for example) and
check that its local tasks (View, Edit, Delete) appear in the Navigation toolbar.

For placement and the four display styles, see
[How to use it](../index.md#how-to-use-it).
