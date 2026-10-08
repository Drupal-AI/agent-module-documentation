# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- No third‑party Composer packages, PHP extensions, or module dependencies are
  required by the base module.

Some optional integrations become available if you also install the suggested
modules: **Inline Entity Form** (enables the Entity Browser IEF submodule),
**Token** (token support in view/display config), and **Entity Embed** (embed
browsed entities into CKEditor).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_browser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_browser -y
```

## Submodules

Entity Browser ships two optional submodules. Enable them with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Browser IEF** | `entity_browser_entity_form` | Adds an *Entity form* widget so editors can create brand-new entities inline inside a browser (via Inline Entity Form) and reference them immediately. Requires the contributed **Inline Entity Form** module. |
| **Entity Browser Example** | `entity_browser_example` | Installs ready-made example browsers you can inspect and adapt. Great for learning; not intended for production. |

For example, to enable inline entity creation:

```bash
drush en entity_browser_entity_form -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Content authoring → Entity
browsers** (`/admin/config/content/entity_browser`). If the browsers listing page
loads with an **Add Entity browser** button, the module is ready. Continue to
[Configuration](../configuration/index.md) to build your first browser.
