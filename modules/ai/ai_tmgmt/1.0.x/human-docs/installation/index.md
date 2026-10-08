# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module, version **^1.0.4** (`drupal/ai`), with at least one AI
  provider configured and its API key stored as a secret. A locally hosted model
  via **Ollama** is supported and is the recommended choice for confidential
  content.
- The **TMGMT** module, version **^1.16** (`drupal/tmgmt`).

Composer pulls both dependencies in for you. Note the current release is a beta
(`1.0.0-beta6`).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_tmgmt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
AI and TMGMT modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_tmgmt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_tmgmt -y
```

Enabling `ai_tmgmt` also enables `ai` and `tmgmt` if they are not already on.

## After enabling

1. Make sure the **AI** module has a provider configured under
   **Configuration → AI** (`/admin/config/ai`), with its API key stored as a
   secret. For unpublished or sensitive content, consider a local Ollama model
   so the text never leaves your infrastructure.
2. Add the AI translator inside TMGMT and point it at that provider — see
   [Configuration](../configuration/index.md).
