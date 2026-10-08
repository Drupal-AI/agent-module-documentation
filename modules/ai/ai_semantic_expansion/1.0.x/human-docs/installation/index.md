# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`ai`) — this is what connects to your AI provider and
  generates the synonyms and intents. It must be installed and configured with a
  working provider (and that provider's API key stored as a secret via the Key
  module / environment).
- The **Search API** module (`search_api`) — this owns the search index that gets
  enriched.

Both are enabled automatically as dependencies when you turn on this module, but
the AI module still needs a configured provider before anything useful happens.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_semantic_expansion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
shared AI and Search API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_semantic_expansion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_semantic_expansion -y
```

Enabling it does not change your search yet. You still need to turn the expansion
on for a specific Search API index and reindex — see
[Configuration](../configuration/index.md).
