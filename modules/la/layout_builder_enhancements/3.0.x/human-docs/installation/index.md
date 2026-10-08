# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`).
- Core's **Block Content** module (`block_content`).

Drupal enables both dependencies automatically when you turn on Layout Builder
Enhancements. There are no third‑party Composer or PHP library requirements.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_enhancements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_enhancements -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_enhancements -y
```

## Submodules — enable only what you need

The functionality is split across three optional submodules. Enable them
individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Blocks** | `layout_builder_enhancements_blocks` | Block‑related enhancements for Layout Builder. |
| **Views** | `layout_builder_enhancements_views` | The View Block — place Views results into a Layout Builder grid with automatic offset calculation. |
| **Visual** | `layout_builder_enhancements_visual` | Visual helpers, including the layout preview view mode for complex block types. |

For example, to add the View Block feature:

```bash
drush en layout_builder_enhancements_views -y
```

Each submodule requires the base Layout Builder Enhancements module, which is
already present once you have installed it above.

## Verify it worked

Open a Layout Builder layout. Depending on the submodules you enabled, you should
see the new View Block available in the add‑block palette and/or richer previews
for the block types you configured. If those appear, the module is working.
