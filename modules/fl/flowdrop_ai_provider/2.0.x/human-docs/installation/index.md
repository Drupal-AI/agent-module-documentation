# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`) — the same minimum as FlowDrop
  itself.
- **FlowDrop** (`flowdrop`) — the visual workflow editor.
- **AI** (`ai`) — the provider abstraction this module routes AI steps through. You
  will need at least one AI provider configured with a valid API key (see
  [Where the API key lives](../index.md#where-the-api-key-lives)).

There are no extra Composer library or PHP version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_ai_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the FlowDrop and AI
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_ai_provider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_ai_provider -y
```

Drupal will enable FlowDrop and the AI module as dependencies if they are not already
on.

## Verify it worked

After enabling, configure an AI provider and key in **Configuration → AI**, then open
a FlowDrop workflow and add an AI node — it should be able to run against the provider
you configured. If AI nodes fail, confirm the provider is set up and the Key resolves
to a valid credential.
