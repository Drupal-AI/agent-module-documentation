# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **AI** module (`ai`) and the **AI Translate** module (`ai_translate`),
  which this module extends. Composer pulls both in as dependencies.
- A configured AI provider with its API key stored as a secret.

There are no additional third-party PHP library requirements. The current
release is a beta (`1.0.0-beta1`).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_translate_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
AI and AI Translate dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_translate_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_translate_plus -y
```

## After enabling

1. Make sure the **AI** / **AI Translate** stack has a provider configured under
   **Configuration → AI** (`/admin/config/ai`), with the API key stored as a
   secret.
2. Grant the module's permission to the roles that should manage the per-bundle
   prompts and field exclusions.
3. Set up the per-entity-type/bundle prompts (per language) and mark any fields
   that should be excluded from translation, then translate content through AI
   Translate as usual.
