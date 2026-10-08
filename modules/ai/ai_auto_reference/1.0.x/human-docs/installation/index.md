# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) with an AI provider configured — this reads the content
  and computes the references. Its API key must be stored via a Key entity backed by
  an environment variable, never in plain config.
- Core's **Node** module (`node`).

This is a **release candidate** (1.0.0‑rc6).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_auto_reference -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI dependency and updates
shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_auto_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_auto_reference -y
```

After enabling, grant the module's permission to the roles that should use
AI‑assisted referencing, and make sure your AI provider is configured.
