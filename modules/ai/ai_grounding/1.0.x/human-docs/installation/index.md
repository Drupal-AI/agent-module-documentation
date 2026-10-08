# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **AI** module (`ai`) — AI Grounding is part of the AI ecosystem and
  depends on it.

The default `lexical_overlap` scorer runs offline and makes no provider calls,
so you do **not** need an AI provider or API key configured just to use
Grounding's built-in scoring. You would only need a provider if you install or
build a scorer plugin that calls out to a model.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_grounding -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_grounding -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_grounding -y
```

Enabling AI Grounding also enables the AI module if it is not already on. Once
enabled, adjust thresholds and enforcement on the settings page — see
[Configuration](../configuration/index.md).
