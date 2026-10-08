# Installation

> **Before you install:** AI ECA integration is **deprecated and will be removed
> in AI 2.0.0**. Only install it on an existing site that already depends on it;
> do not build new automations on it.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — the AI operations run through it.
- The **ECA** module — this integration provides plugins for ECA, so you need
  ECA installed to use them.
- A configured AI **provider** with its API key stored as a **Key** entity.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_eca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_eca -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_eca -y
```

Once enabled, the module's AI actions and conditions become available in the ECA
model editor. There is no separate settings form for this module — configure the
AI provider through the AI module.
