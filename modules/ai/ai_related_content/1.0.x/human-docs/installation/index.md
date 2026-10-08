# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **Block** (`block`) modules.
- The **Search API** module (`search_api`).
- The **AI Search** module (`ai_search`) — provides the semantic (vector)
  similarity this block relies on. AI Search in turn needs the AI module with a
  configured provider and a Search API index built over your content.

Drupal pulls the module dependencies in automatically. The AI provider and its
key must be set up separately (see AI Search).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_related_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_related_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_related_content -y
```

## After enabling

1. Make sure **AI Search** is working: an AI provider configured (key stored as a
   Key), and a Search API index built and indexed over the content you want to
   relate. **Verify the index respects content access** so the block cannot
   surface restricted content.
2. Place the AI Related Content block at **Structure → Block layout** and
   configure it there.

See the [overview](../index.md) for how to place and use the block.
