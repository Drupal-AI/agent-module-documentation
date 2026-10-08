# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- **[AI Search](https://www.drupal.org/project/ai_search)** (`ai_search`, `^1.2`),
  which in turn needs the [AI module](https://www.drupal.org/project/ai) and a
  configured embeddings provider.
- The **[Search API module](https://www.drupal.org/project/search_api)**
  (`search_api`), with an index the block can query.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_search_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update AI
Search, the AI module, and Search API as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_search_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_search_block -y
```

## Submodules — enable only what you need

AI Search Block ships four optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Extras** | `ai_search_block_extras` | Additional presentation/behaviour options for the search block. |
| **Header** | `ai_search_block_header` | A header-style search variant. |
| **Log** | `ai_search_block_log` | Records AI search queries. **Queries can be sensitive** — restrict access to the log and set a retention approach. |
| **Log Tag** | `ai_search_block_log_tag` | Tagging on top of the search log. |

For example, to add the logging submodule:

```bash
drush en ai_search_block_log -y
```

Continue to [Configuration](../configuration/index.md) to place and configure the
block.
