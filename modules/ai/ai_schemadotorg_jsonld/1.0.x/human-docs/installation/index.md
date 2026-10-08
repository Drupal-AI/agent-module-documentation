# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3`).
- **AI Automators** (`ai:ai_automators`) — the AI module submodule that drives
  the automated generation.
- **JSON Field** (`json_field`) — stores the generated JSON‑LD.
- **Field Widget Actions** (`field_widget_actions`) — adds the trigger button on
  the field widget.
- A working **AI provider** configured in the AI module, with its API key stored
  via the **Key** module.

Drupal pulls the module dependencies in automatically.

> **Version note:** at the time these docs were written the module was an early
> alpha release (1.0.0‑alpha1). Treat it as a preview.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_schemadotorg_jsonld -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in JSON Field and Field Widget Actions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_schemadotorg_jsonld -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_schemadotorg_jsonld -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Breadcrumb** | `ai_schemadotorg_jsonld_breadcrumb` | Adds breadcrumb structured data to the generated JSON‑LD. |
| **Log** | `ai_schemadotorg_jsonld_log` | Logs the generation activity. |

Enable them individually, for example:

```bash
drush en ai_schemadotorg_jsonld_log -y
```

## After enabling

Confirm an **AI provider** is configured in the AI module (key stored as a Key),
then set up the AI Automator on the content you want marked up. See the
[overview](../index.md) for how the pieces fit together, and review the generated
JSON‑LD before publishing.
