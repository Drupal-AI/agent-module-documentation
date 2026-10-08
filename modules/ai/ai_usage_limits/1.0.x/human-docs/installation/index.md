# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`), installed and configured with at least one provider.
  This module caps usage of the providers the AI module knows about, so it only
  does anything useful once a provider (for example OpenAI) is set up with its API
  key stored as a secret.
- Drupal **cron** running on a schedule — the retention window that resets the
  counters is cleared on cron runs.

The AI module is enabled automatically as a dependency. There are no third-party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_usage_limits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_usage_limits -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_usage_limits -y
```

Enabling the module does not impose any limits by default — nothing is capped
until you set values on the settings form. Head to
[Configuration](../configuration/index.md) to set quotas per provider.
