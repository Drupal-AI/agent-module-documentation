# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI Assistant API** (`ai_assistant_api`) and **AI Chatbot**
  (`ai_chatbot`) modules — part of the AI project; the evaluations run against
  their responses.
- Core **Views** (`views`) — used to present evaluation results.
- A configured AI **provider** whose API key is stored as a **Key** entity (see
  below).

This is an early release (0.1.0), so test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_evaluations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI Assistant
API and AI Chatbot dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_evaluations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_evaluations -y
```

This also enables the AI Assistant API, AI Chatbot and core Views modules if they
are not already on.

## After enabling

Grant the module's evaluation permission only to trusted developers and admins,
and make sure the AI provider's API key is stored securely: save it in an
environment variable, wrap it in a **Key** entity, and point the provider at that
key. See [How to use it](../index.md#how-to-use-it) in the overview.
