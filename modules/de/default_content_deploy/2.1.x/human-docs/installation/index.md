# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **HAL** module (`hal`) — DCD uses it for serialization, and Drupal
  enables it automatically as a dependency.
- **Optional:** the **Better Normalizers** module (`better_normalizers`) if you
  want to export files along with your content.

There is no PHP library or third‑party Composer requirement beyond the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/default_content_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/default_content_deploy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_content_deploy -y
```

## Submodules

DCD ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Default Content Deploy** | `search_api_default_content_deploy` | Integrates with Search API to track content changes and configure "continuous content export streams", so you can automate what gets exported based on Search API indexing. Enable it only if you use Search API and want that automation. |

Enable it with:

```bash
drush en search_api_default_content_deploy -y
```

## Verify it worked

After enabling, confirm the Drush commands are available:

```bash
drush list --filter=default-content-deploy
```

You should see `default-content-deploy:export` (`dcde`),
`default-content-deploy:import` (`dcdi`), and the related commands. Next, set
your content directory and review the command reference in
[Configuration](../configuration/index.md).
