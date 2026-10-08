# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- The **AI Agents** module (`ai_agents`) — runs the agent that composes answers.
- The **AI Search** module (`ai_search`) — indexes your content and performs the
  retrieval that grounds answers.
- Through those, the base **AI** module with a configured AI provider. Its API key
  must be stored securely — via a Key entity backed by an environment variable —
  never pasted into plain configuration.

This is an **alpha** release (1.0.0‑alpha2).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_answers -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI Agents and AI Search
dependencies and updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_answers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_answers -y
```

After enabling, make sure AI Search has indexed your content, configure AI Answers'
retrieval, and grant the **use ai answers** permission to the roles that should be
able to ask questions.
