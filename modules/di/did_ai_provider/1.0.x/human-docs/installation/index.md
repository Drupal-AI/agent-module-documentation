# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Module dependencies (Composer resolves these automatically):
  - **AI** (`ai`) — Drupal's AI module and its AI Automators framework.
  - **Key** (`key`) — used to store the D-ID API credential securely.
- A **D-ID API account and API key** (from https://www.d-id.com).
- Recommended: the **Media** and **File Entity** modules for more flexible
  handling of audio and image files.

## Install with Composer

Installing with Composer is recommended so the AI and Key dependencies are pulled
in for you. From the project root:

```bash
composer require drupal/did_ai_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/did_ai_provider -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en did_ai_provider -y
```

Enabling this module also enables its dependencies, AI and Key.

## Verify it worked

After enabling, the provider settings form should be reachable at
**Configuration → AI → D-ID Provider settings** (`/admin/config/ai/di-ai-provider`),
and a new **D-ID: Image + Audio → Video** AI Automator becomes available on file
fields. Next, store your D-ID key and connect it — see
[Configuration](../configuration/index.md).
