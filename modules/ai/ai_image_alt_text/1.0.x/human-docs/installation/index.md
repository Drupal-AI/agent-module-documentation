# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **AI (AI Core)** module, version `^1.0.0` (`drupal/ai`) — this is the
  backend that actually talks to the AI model. It is pulled in as a Composer
  dependency.

**Important prerequisite:** the module has no AI of its own. You must have an AI
Core **provider configured with a vision-capable chat model** — either set as the
site default for the `chat_with_image_vision` operation, or chosen explicitly on
this module's settings form. Until one is available, the *Generate with AI*
button will not appear. Setting up an AI provider (for example OpenAI or
Anthropic) is done in AI Core; see its own documentation.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_image_alt_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the AI Core module if it isn't already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_image_alt_text -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_image_alt_text -y
```

After enabling, grant the **Generate AI alt tags** permission to the roles that
should see the button, then visit the settings page to confirm a provider is
resolved — see [Configuration](../configuration/index.md).

## Submodule — bulk generation

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AI Image Bulk Alt Text** | `ai_image_bulk_alt_text` | A batch UI to generate alt text for many images that are missing it, all at once — useful for backfilling an existing media library. |

Enable it only if you need bulk generation:

```bash
drush en ai_image_bulk_alt_text -y
```

It requires the base AI Image Alt Text module, which is already present once you
have installed it above.
