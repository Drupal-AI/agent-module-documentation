# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **CKEditor Mentions** (`ckeditor_mentions`) — powers the `@`-mention experience.
- The **AI** module (`ai`) — connects Crux to your AI provider (e.g. OpenAI).
- Core **User** (`user`) and **System** (`system`) modules.
- An account with an **AI provider** (such as OpenAI) and its API key, configured
  through the AI module.

## Install with Composer

From the project root:

```bash
composer require drupal/crux -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in CKEditor Mentions,
the AI module, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crux -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crux -y
```

The dependencies (CKEditor Mentions, AI, and core User/System) will be enabled
alongside it if they aren't already.

## Verify it worked

Log in as an administrator and go to **Configuration → AI → Crux**
(`/admin/config/ai/crux`); the settings form should load. Crux isn't functional yet,
though — you still need to configure the mentions filter, set up an AI provider, and
run the queue. Follow [Configuration](../configuration/index.md).
