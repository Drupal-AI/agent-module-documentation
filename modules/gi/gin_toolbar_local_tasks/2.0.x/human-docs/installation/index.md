# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) — the only dependency, and Drupal enables
  it automatically when you turn this module on.

Note that the **2.x** release does *not* require the Gin Toolbar module (unlike
1.x). The Gin admin theme is a natural companion but is not a hard requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/gin_toolbar_local_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gin_toolbar_local_tasks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_toolbar_local_tasks -y
```

## Verify it worked

Open any admin page that has tabs — for example a node's edit page, or **Structure
→ Content types → *(a type)* → Manage fields**. The local‑task tabs should now
appear in the toolbar instead of inline on the page. There is no configuration to
set.
