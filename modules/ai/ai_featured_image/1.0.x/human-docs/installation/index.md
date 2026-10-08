# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **Node** (`node`) and **File** (`file`) modules — the image is attached
  to a node and stored as a managed file.
- An AI **image-generation provider** configured through the AI module, with its
  API key stored as a **Key** entity (see below). Although the AI module is not
  listed as a hard dependency, image generation runs through an AI provider, so
  you need one configured for the feature to work.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_featured_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_featured_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_featured_image -y
```

## Store the provider API key safely

Keep the AI image provider's key out of version control and plain config: save it
into an environment variable (for example `ddev dotenv set .ddev/.env
--openai-api-key=<value>`, then `ddev restart`), create a **Key** entity that
reads from that variable, and point your AI image provider at that key. Then
grant the module's permission to the users who should generate images — see
[How to use it](../index.md#how-to-use-it) in the overview.
