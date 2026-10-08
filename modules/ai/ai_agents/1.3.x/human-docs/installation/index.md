# Installation

## Requirements

AI Agents needs Drupal 10.3+ or 11 and two other contrib modules, which Composer
pulls in automatically:

- **AI Core** (`ai`) — talks to the AI providers (OpenAI, Anthropic, …).
- **Modeler API** (`modeler_api`) — supplies the admin UI for editing agents.

Optional but useful:

- **BPMN.iO** (`bpmn_io`) — lets you edit an agent visually as a BPMN diagram.
- **Key** (`key`) — the recommended place to store your provider API key.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_agents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the `ai` and
`modeler_api` dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_agents -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_agents -y
```

This also enables `ai` and `modeler_api`. Once enabled, the agent screens appear
under **Configuration → AI Setup and Configuration → Tools & Automation → Configure
AI Agents**.

## Submodules — enable only what you need

AI Agents ships several optional submodules. Enable them individually:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Explorer** | `ai_agents_explorer` | An interactive page to run and debug agents. Recommended — the [Running an agent](../running-an-agent/index.md) guide uses it. |
| **Extra Agents** | `ai_agents_extra` | Experimental agents for Views, Webform, and enabling modules. |
| **Form Integration** | `ai_agents_form_integration` | AI‑assisted "fill this config form for me" UI. |
| **Extra Tools** | `ai_agents_extra_tools` | Deprecated — do not enable on new sites. |

For example, to enable the Explorer:

```bash
drush en ai_agents_explorer -y
```

## Verify it worked

Log in as an administrator and go to
`/admin/config/ai/tools-automation/agents`. You should see the three default agents
— **Content Type Agent**, **Field Agent**, and **Taxonomy Agent** — listed:

![The agent list after installation](../images/agents-list.png)

If the page loads and the three agents are listed, the module is installed
correctly. Next, [connect an AI provider](../configuration/index.md) so the agents
can actually run.
