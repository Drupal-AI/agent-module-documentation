# Installation

## Requirements

- **Drupal 10.6 or 11.3** (`core_version_requirement: ^10.6 || ^11.3`).
- The **AI** module (`ai`) with a configured provider — the actions send text to
  it.
- Core **CKEditor 5** (`ckeditor5`) — the actions are editor buttons.
- A configured AI **provider** whose API key is stored as a **Key** entity (see
  below).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_editor_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_editor_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_editor_actions -y
```

This also enables the AI module and core CKEditor 5 if they are not already on.

## Turn on the actions

The module has no central settings form. To make the AI actions appear, edit a
CKEditor 5 text format at **Configuration → Content authoring → Text formats and
editors** and add the module's AI button(s) to the toolbar, then save. See
[How to use it](../index.md#how-to-use-it) in the overview.

## Store the provider API key safely

Keep the AI provider's key out of version control and plain config: save it into
an environment variable (for example `ddev dotenv set .ddev/.env
--openai-api-key=<value>`, then `ddev restart`), create a **Key** entity that
reads from that variable, and point your AI provider at that key.
