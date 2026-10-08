# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3||^11`).
- No third‑party Composer or PHP library requirements, and no other contrib
  module dependencies.
- **Drupal Canvas** — *optional*. Install it only if you want the swatch picker
  to appear in the Canvas component editor; the field and formatters work without
  it.

## Install with Composer

From the project root:

```bash
composer require drupal/curated_colors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/curated_colors -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en curated_colors -y
```

## Submodules

Curated Colors ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Curated Colors Example** | `curated_colors_example` | A sample palette config, a working Single‑Directory Component, and a CSS‑class example that demonstrates the full "store a key, render from CSS" pattern. Handy for learning the module; not needed in production. |

Enable it if you'd like the worked example to study:

```bash
drush en curated_colors_example -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring →
Curated Colors** (`/admin/config/content/curated-colors`). You should see the
palette collection screen, ready for you to create your first palette — see
[Configuration](../configuration/index.md).
