# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third‑party Composer or PHP library requirements, and no required contrib
  dependencies — Flag builds on core's Entity and Views APIs.

## Install with Composer

From the project root:

```bash
composer require drupal/flag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag -y
```

## Submodules — enable only what you need

Flag ships three example submodules that give you a working flag out of the box —
handy as starting points or to study:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Flag Bookmark** | `flag_bookmark` | A ready‑made "Bookmark" flag so users can save content to a personal list. |
| **Flag Follower** | `flag_follower` | A "Follow" flag for following users or content. |
| **Flag Count** | `flag_count` | Flag‑count features demonstrating the count manager. |

For example:

```bash
drush en flag_bookmark -y
```

Each submodule requires the base Flag module, which is already present once you
have installed it above.

## Next steps

With the module enabled, go to **Structure → Flags → Add flag** to create your
first flag — see [Configuration](../configuration/index.md) for a field‑by‑field
walkthrough.
