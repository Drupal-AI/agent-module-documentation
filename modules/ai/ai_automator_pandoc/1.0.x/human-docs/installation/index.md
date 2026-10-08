# Installation

## Requirements

- **Drupal 10.4, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- The **AI Automators** module (`ai_automators`, part of the
  [AI](https://www.drupal.org/project/ai) project) enabled, with a working AI
  provider configured. AI Automators is the framework this module plugs into.
- Core's **System** module (always present).
- **pandoc installed on the server.** Conversion shells out to the `pandoc`
  program, so the binary must be available in the environment where Drupal runs.
  Inside a DDEV container you can add it, for example, with
  `ddev exec 'sudo apt-get update && sudo apt-get install -y pandoc'` (or bake it
  into your `.ddev` config), then confirm it is present with
  `ddev exec 'pandoc --version'`.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_automator_pandoc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_automator_pandoc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_automator_pandoc -y
```

This also pulls in the AI Automators module if it is not already on. Once enabled,
the pandoc converter is available as an automator you can attach to a field — see
[How to use it](../index.md#how-to-use-it).

## A note on secrets

This module itself handles no API keys — pandoc runs locally. But the AI
Automators / AI stack it works alongside talks to an LLM provider whose API key
must be stored securely. Never paste a provider key into plain configuration:
store it in an environment variable (with DDEV, `ddev dotenv set .ddev/.env
--openai-api-key=<value>` then `ddev restart`) and reference it through a **Key**
entity, as the AI module expects.
