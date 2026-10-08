# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** (`ai`) and **AI Agents** (`ai_agents`) modules — dependencies that
  provide the agent framework and AI‑provider connection. Composer and Drupal pull
  them in.
- A configured **AI provider** with a valid API key (set up through the AI module —
  see below).

There are no third‑party PHP library requirements from this module itself.

## Install with Composer

This module ships as part of the **`drup_aid`** project, so require that package
(not the submodule name). From the project root:

```bash
composer require drupal/drup_aid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI and AI
Agents modules together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drup_aid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drup_aid_cockpit -y
```

## Set up your AI provider key

The cockpit relies on the AI module for the connection to your AI provider, and
that means an API key. Never hard‑code or commit an API key — store it as an
environment variable and reference it from Drupal through the **Key** module.

With DDEV, save the secret into DDEV's dotenv file and restart so it is available
in the container:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart
```

Then create a Key entity that reads it from the environment (adjust the label and
provider module to match your chosen AI provider), and configure your provider in
the AI module's settings. Keep `.ddev/.env` out of version control.

## Grant access

The cockpit provides the **access drup-aid cockpit** permission. Grant it to the
roles that should watch and steer the agents:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Tick **access drup-aid cockpit** for the appropriate role(s).
3. Click **Save permissions**.

## Verify it worked

Log in as a user who holds the **access drup-aid cockpit** permission and open the
cockpit screen. With your AI provider configured in the AI module, you should be
able to watch the Drup-AID master agent and its sub‑agents, and steer them.
