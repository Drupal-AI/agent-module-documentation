# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **System** and **User** modules (always present in a standard install).
- An **OpenAI account** with an API key and available credit — the chatbot runs
  every visitor message through OpenAI on your key.

Store the OpenAI key as an environment-backed secret rather than committing it or
pasting it into plain configuration. On DDEV, set it once with
`ddev dotenv set .ddev/.env --openai-api-key=<value>` and `ddev restart`, then
reference that variable when you configure the chatbot's OpenAI connection.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_lead_chatbot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_lead_chatbot -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_lead_chatbot -y
```

There are no submodules.

## Grant permissions

At **People → Permissions**:

- **Administer AI Lead Chatbot** — access to the settings form; keep to trusted
  admins.
- **View chatbot leads** (`view chatbot leads`) — see captured leads.
- **Manage chatbot leads** (`manage chatbot leads`) — edit or remove leads.

## Before you go live

The chat endpoints (`/chat/start`, `/chat`) are open to anonymous visitors, and
each message bills an OpenAI call to your key. Before exposing the widget on
public, high-traffic pages:

- Set a spending cap on the OpenAI key.
- Monitor the leads table growth so you can size capacity for the traffic you
  expect.

Then connect OpenAI in the settings form and start capturing leads — see
[How to use it](../index.md#how-to-use-it).
