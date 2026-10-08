# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
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
handy as starting points or to study. Each depends on the base Flag module plus
core's Views and Node:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Flag Bookmark** | `flag_bookmark` | A ready‑made "Bookmark" flag and supporting views so users can save content to a personal list. |
| **Flag Follower** | `flag_follower` | An example "Follow" (user) flag and supporting views. |
| **Flag Count** | `flag_count` | A link type that displays the flag count alongside the flag. |

For example:

```bash
drush en flag_bookmark -y
```

## Next steps

With the module enabled, go to **Structure → Flags → Add flag** to create your
first flag — see [Configuration](../configuration/index.md) for a field‑by‑field
walkthrough.
