# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No hard module dependencies for the base module, but the submodules build on the
  relevant subsystems — for example `orchestration_eca` on ECA, and the AI
  submodules on Drupal's AI modules — so enable those alongside the submodules you
  choose.
- Access to an external automation platform (**Activepieces** at this version).

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/orchestration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orchestration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en orchestration -y
```

## Submodules — enable only what you need

Orchestration's capabilities come from submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AI Agents** | `orchestration_ai_agents` | Makes Drupal AI agents callable from external platforms. |
| **AI Function** | `orchestration_ai_function` | Exposes AI functions (note: these can send data to external LLMs). |
| **ECA** | `orchestration_eca` | Lets ECA workflows be triggered from outside Drupal. |
| **Tool** | `orchestration_tool` | Lets tool plugins be invoked remotely. |

For example, to expose ECA workflows to your automation platform:

```bash
drush en orchestration_eca -y
```

## Verify it worked

Confirm the base module and your chosen submodules are enabled
(`drush pml | grep orchestration`). Then head to
[Configuration](../configuration/index.md) to connect your external platform, store
its credentials safely, and restrict who can configure orchestrations.
