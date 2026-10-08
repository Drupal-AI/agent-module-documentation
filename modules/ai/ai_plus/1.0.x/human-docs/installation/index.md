# Installation

## Requirements

AI + ties several AI and editing modules together:

- **Drupal 11** (`core_version_requirement: ^11`).
- **Navigation Plus** (`navigation_plus`) — the edit-mode experience the
  assistant lives in.
- The AI module's **AI Chatbot** submodule (`ai_chatbot`) — enabled and backed by
  a configured AI provider.
- **AI Agents** (`ai_agents`) — lets the assistant act on entities.
- **Entity Blueprint** (`entity_blueprint`, plus its AI companion) — used when
  building content/configuration.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as Navigation Plus, AI Chatbot, AI Agents, and Entity
Blueprint.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_plus -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_plus -y
```

Drupal enables Navigation Plus, AI Chatbot, AI Agents, and Entity Blueprint as
dependencies if they are not already on.

## After enabling

1. Confirm the **AI** module has a provider configured with a working API key
   (stored as a secret via the Key module, per this project's conventions).
2. Grant the **Use AI assistant** permission (`use ai assistant`) only to trusted
   editors — the assistant can create and modify entities.
3. Enter Edit Mode via Navigation Plus and the AI chatbot tool will be available
   there.
