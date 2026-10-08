# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Agents** module (`ai_agents`) — the commands drive this framework,
  which in turn builds on the AI module.
- A configured AI **provider** with its API key stored as a **Key** entity, so
  the agents have a model to call.
- **Drush** available in your environment (standard on Drupal sites).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_drush_agents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI Agents
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_drush_agents -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_drush_agents -y
```

This also enables the AI Agents module if it is not already on. There is no
settings form; the module's Drush commands become available immediately. See
[How to use it](../index.md#how-to-use-it) in the overview for running them.
