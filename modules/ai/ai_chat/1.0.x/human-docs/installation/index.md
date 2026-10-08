# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Agents** (`ai_agents`) and **AI Assistant API** (`ai_assistant_api`)
  modules enabled — these provide the assistant that the chat widget talks to.
  They in turn build on the [AI](https://www.drupal.org/project/ai) module and a
  configured AI provider.
- Core's **User** module (always present).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_chat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in AI Agents, AI
Assistant API, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_chat -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_chat -y
```

This pulls in AI Agents and AI Assistant API if they are not already on. After
enabling, configure an AI provider and build an assistant as described in
[How to use it](../index.md#how-to-use-it).

## A note on secrets

The assistant behind the widget talks to an LLM provider whose API key must be
stored securely — never pasted into plain configuration. Store the key in an
environment variable (with DDEV, `ddev dotenv set .ddev/.env
--openai-api-key=<value>` then `ddev restart`) and reference it through a **Key**
entity, which is how the AI module reads provider credentials. Remember that
whatever visitors type into the chat is sent to that provider.
