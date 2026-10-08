# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`drupal/ai ^1.2`),
  configured with at least one provider and model.
- **[AI Agents](https://www.drupal.org/project/ai_agents)** (`drupal/ai_agents
  ^1.2`).
- **[ECA](https://www.drupal.org/project/eca)** (`drupal/eca ^2 || ^3`).
- The **[Token](https://www.drupal.org/project/token)** module
  (`drupal/token ^1.15`).
- Core's **File** module (always present).

Composer pulls in the required contrib modules automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_integration_eca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the AI, AI Agents, ECA, and Token modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_integration_eca -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_integration_eca -y
```

This enables the AI, ECA, and related dependencies if they are not already on. The
five AI actions then become available when you build an ECA model. There is no
configuration form — see the *How to use it* section of the [overview](../index.md).

## Submodules — enable only what you need

The project ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AI Integration ECA – Agents** | `ai_integration_eca_agents` | An AI agent plus an *Ask AI* form that can build or answer questions about ECA models. |
| **AI Integration ECA – Automators** | `ai_integration_eca_automators` | Wires AI Automators into ECA and vice‑versa — trigger an Automator from an ECA action, or expose an ECA process as an Automator worker. |

For example:

```bash
drush en ai_integration_eca_agents -y
```

Each submodule requires the base module, which is already present once you have
installed it above.

## Verify it worked

Go to **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`), create or
edit a model, and add an action. You should see AI actions such as *Chat*,
*Embedding*, *Moderation*, *Speech to Text*, and *Text to Speech* in the action
list. (They only run once the AI module has a working provider/model for that
operation type.)
