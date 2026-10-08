# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- The **AI** module (`ai`) — this is the core dependency; AI Decoupled exposes
  its chat processors, so you need a working AI module with at least one
  configured provider before the endpoints can return anything.
- An AI **provider** configured in the AI module, with its API key stored as a
  **Key** entity (never pasted into plain configuration). See the note below.
- For real calls from a client, an authentication method: **OAuth2** (for
  example the Simple OAuth module) or HTTP **basic auth**.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_decoupled -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_decoupled -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_decoupled -y
```

Enabling AI Decoupled also enables the AI module if it is not already on.

## Storing the provider API key safely

AI Decoupled runs your configured AI provider, and that provider needs an API
key. Keep the key out of version control and out of plain config:

1. Save the value into an environment variable with DDEV's dotenv command, for
   example `ddev dotenv set .ddev/.env --openai-api-key=<value>`, then
   `ddev restart`.
2. Create a **Key** entity that reads from that environment variable (the Key
   module ships an env provider), and point your AI provider at that key.

The AI module documents this provider setup; AI Decoupled simply reuses
whatever provider you have already configured.
