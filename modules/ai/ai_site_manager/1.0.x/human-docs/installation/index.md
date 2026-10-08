# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) and core's **System** module (enabled by default).
- Optionally, a configured **AI provider** in the AI module. A provider is *not*
  strictly required: without one, requests are interpreted by keyword matching
  instead of by the LLM. With a provider, its API key must be stored as a secret
  (a Key entity or an environment variable), not in plain configuration.

There are no additional third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_site_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the AI module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_site_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_site_manager -y
```

## After enabling

1. Grant permissions deliberately: **access AI site manager** to users who may
   preview actions, and the restricted **administer AI site manager** only to
   those trusted to confirm and execute commands and to change settings.
2. Optionally configure an AI provider under **Configuration → AI**
   (`/admin/config/ai`) with its API key stored as a secret, so requests are
   interpreted by the LLM rather than by keyword matching.
3. See [Configuration](../configuration/index.md) to set the provider/model and
   the flood limit, and to learn how the two-step preview-then-confirm safety
   model works.
