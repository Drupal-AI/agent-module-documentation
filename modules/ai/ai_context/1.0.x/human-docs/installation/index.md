# Installation

## Requirements

- **Drupal 10.5 or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) and the **AI Agents**
  module (`ai_agents`) — this module manages context for their prompts.
- Core's **Content Moderation** (`content_moderation`), **Options** (`options`), and
  **Taxonomy** (`taxonomy`) modules. Content Moderation powers the draft/review
  workflow for context items; Taxonomy backs the tag scope.

Composer pulls in what it can, but make sure the AI and AI Agents modules are set up
and configured (with a working AI provider) for context to actually reach prompts.

> **Beta software.** The installed release is `1.0.0-beta3`. Entity schemas and
> plugin signatures may still change between releases — pin the version and test
> upgrades before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI, AI Agents,
and other dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_context -y
```

There are no submodules. Once enabled, continue to
[Configuration](../configuration/index.md) to start creating context items.
