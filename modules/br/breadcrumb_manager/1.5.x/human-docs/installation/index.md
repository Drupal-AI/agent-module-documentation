# Installation

## Requirements

Breadcrumb Manager is self‑contained:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. The optional Context submodule (below) needs the contributed
**Context** module.

## Install with Composer

From the project root:

```bash
composer require drupal/breadcrumb_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/breadcrumb_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breadcrumb_manager -y
```

As soon as it is enabled, Breadcrumb Manager takes over as the site's breadcrumb
builder (it registers with a high priority) — path‑based breadcrumbs appear
immediately, with no required configuration. Grant the **Administer Breadcrumb
Manager** permission to any role that should be able to open the settings form.

## Optional: the Context submodule

Breadcrumb Manager ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Breadcrumb Manager Context** | `breadcrumb_manager_context` | An extra title‑resolver plugin that sources breadcrumb segment titles from the contributed **Context** module. Enable it only if you use Context and want it to drive breadcrumb titles. |

```bash
drush en breadcrumb_manager_context -y
```

This submodule requires the contributed **Context** module to be installed.

## Verify it worked

Visit a page a couple of levels deep in your site's URL structure. You should see a
path‑based breadcrumb, with "Home" at the start (unless you disable it). Then open
**Configuration → User interface → Breadcrumb Manager** to tune the behavior — see
[Configuration](../configuration/index.md).
