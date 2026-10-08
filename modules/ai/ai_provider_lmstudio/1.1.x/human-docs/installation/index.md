# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI module** (`drupal/ai`) enabled — this is the framework the provider
  plugs into. Composer pulls it in automatically as a dependency.
- A running **LM Studio** instance with at least one model loaded and its local
  server started. This runs outside Drupal (on your workstation or a server you
  control) — install it from [lmstudio.ai](https://lmstudio.ai/).

There are no extra PHP libraries to install. A local LM Studio server usually
needs no API key, so the Key module is not a hard requirement here.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_lmstudio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_lmstudio -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_lmstudio -y
```

This module ships no submodules — enabling `ai_provider_lmstudio` is all you
need. Next, point it at your LM Studio server in
[Configuration](../configuration/index.md).
