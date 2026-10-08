# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drush** available in your environment (standard on Drupal sites).

AI Drush Tools has **no other module dependencies** — it does not require the AI
module to install. Its upgrade-check and project-inspection commands are the core
feature; AI assistance is optional, and where you use it you would need a
configured AI provider (with its API key stored as a **Key** entity) available on
the site.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_drush_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_drush_tools -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_drush_tools -y
```

There is no settings form; the module's Drush commands become available
immediately. See [How to use it](../index.md#how-to-use-it) in the overview for
listing and running them.
