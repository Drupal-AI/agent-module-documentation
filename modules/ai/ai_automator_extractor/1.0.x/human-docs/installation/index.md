# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Automators** module (`ai_automators`, part of the AI ecosystem) — this
  plugin runs inside its workflow chains. Through it you will have the base AI
  module and need an AI provider configured, with its API key stored via a Key
  entity / environment variable rather than plain config.

This is a **beta** release (1.0.0‑beta2).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_automator_extractor -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI Automators dependency and
updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_automator_extractor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_automator_extractor -y
```

Once enabled, the extractor becomes available as a step you can add inside an **AI
Automators** chain. There is no separate settings page — you configure it within the
chain.
