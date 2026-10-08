# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`).
- The **AI** module (`ai`) — provides the connection to a large language model and
  handles the API key.
- The **AI Agents** module (`ai_agents`) — the framework this sub‑agent runs on.
- An account and API key with an AI provider supported by the AI module.

> **Note on naming:** the machine name of this module is `peak_web_agent`, but it
> ships inside the **Drup‑AID** project, so the Composer package is
> `drupal/drup_aid`. Install the package by its Composer name and enable the module
> by its machine name, as shown below.

## Install with Composer

From the project root:

```bash
composer require drupal/drup_aid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it brings in the AI and AI Agents modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drup_aid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en peak_web_agent -y
```

This also enables the `ai` and `ai_agents` modules if they are not already on.

## Configure an AI provider and key

Peak Web Agent relies on the **AI** module for its LLM connection. Store the
provider's API key in an environment variable rather than in configuration. With
DDEV:

```bash
ddev dotenv set .ddev/.env --ai-provider-api-key=<your-key>
ddev restart
```

Then configure the provider and key in the AI module's settings (the AI module
supports storing the key via a **Key** entity backed by that environment variable —
see your provider's guidance). Never commit `.ddev/.env` or hard‑code the key.

## Verify it worked

1. Confirm the `ai` and `ai_agents` modules are enabled and that an AI provider is
   configured and reachable.
2. Grant your user the Drup‑AID cockpit permission under **People → Permissions**.
3. Open the Drup‑AID cockpit and ask the Web Design Editor to make a small copy
   change on a test page. Confirm the change appears as a new **revision** on that
   node, which you can review and roll back.
