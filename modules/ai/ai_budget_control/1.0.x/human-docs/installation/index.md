# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) enabled. AI Budget
  Control listens to the AI module's generate events, so it only meters usage that
  goes through the AI module's provider system.

There are no third‑party Composer or PHP library requirements, and the module
itself makes no outbound HTTP calls and handles no API keys.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_budget_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_budget_control -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_budget_control -y
```

Out of the box, anonymous AI requests are already flood‑limited by client IP to
20 per hour. To start capping and metering usage deliberately, create one or more
limits — see [Configuration](../configuration/index.md).
