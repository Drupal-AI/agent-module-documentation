# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) and the **Tool** module (`tool`), which provide the
  agent/tool framework this plugs into. Composer pulls both in as dependencies.
- A configured AI provider in the AI module, with its API key stored as a secret,
  for the agents that will use the tool.

There are no additional third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_tool_get_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the AI and Tool modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_tool_get_sitemap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_tool_get_sitemap -y
```

Once enabled, the "get sitemap" tool is available to assign to AI agents in the
AI/Tool framework (under **Configuration → AI**, `/admin/config/ai`). Make sure
the AI module has a provider configured, with its API key stored as a secret,
before an agent uses it.
