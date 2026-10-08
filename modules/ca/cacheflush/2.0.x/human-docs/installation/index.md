# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`cacheflush_entity`** submodule (ships with the project) is **required** —
  it provides the storage entity that presets are saved as, and Drupal enables it
  automatically.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cacheflush -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cacheflush -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cacheflush -y
```

The required `cacheflush_entity` submodule is enabled automatically. On its own,
the base module gives you the clear engine and the two ready-made clear links,
but **no UI to build presets** — for that you want the UI submodule below.

## Submodules — enable what you need

CacheFlush ships several submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity** | `cacheflush_entity` | The storage entity that presets are saved as. **Required** — enabled automatically with the base module. |
| **UI** | `cacheflush_ui` | The preset add/edit forms (the option catalogue rendered as checkboxes), an admin listing under **Structure**, a menu-integration option for presets, and finer-grained permissions. This is what most people need to actually create presets. |
| **Advanced** | `cacheflush_advanced` | Extra clear options — clearing specific cache IDs (`cid`) and invalidating specific cache tags. |
| **Cron** | `cacheflush_cron` | Run a preset automatically on a schedule (via Ultimate Cron). |
| **Drush** | `cacheflush_drush` | A Drush command to clear a preset from the command line. Note: this command was observed to be broken against this site's Drush version — see its own docs. |

For the typical setup, enable the UI so you can build presets:

```bash
drush en cacheflush_ui -y
```

Then head to [Configuration](../configuration/index.md) to build your first
preset.
