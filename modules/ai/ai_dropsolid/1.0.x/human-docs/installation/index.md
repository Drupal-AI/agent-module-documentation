# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Dropsolid AI provider** module (`ai_provider_dropsolidai`) — the direct
  dependency, which in turn brings in the **AI** module (`ai`).
- Dropsolid platform **credentials** for the AI provider, stored as a secret
  (see below). This bundle is intended for sites running on Dropsolid.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_dropsolid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Dropsolid AI
provider and the AI module and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_dropsolid -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_dropsolid -y
```

This also enables the Dropsolid AI provider and the AI module if they are not
already on, and applies the bundle's preconfigured provider settings.

## Store the credentials safely

Keep the Dropsolid provider credentials out of version control and plain config:

1. Save the value into an environment variable with DDEV's dotenv command, for
   example `ddev dotenv set .ddev/.env --dropsolid-ai-key=<value>`, then
   `ddev restart`.
2. Create a **Key** entity that reads from that environment variable.
3. Point the Dropsolid AI provider at that Key in the AI module's provider
   configuration.
