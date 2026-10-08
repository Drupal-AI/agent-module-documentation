# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) — the Watchdog log this module
  analyzes.
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working AI provider (this is what interprets the log entries).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_watchdog_analyst -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_watchdog_analyst -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_watchdog_analyst -y
```

This ensures `dblog` and `ai` are enabled too. Then grant the module's permission
to the operators who should run the AI analysis.

> **Data egress:** log entries you analyze are sent to your configured AI
> provider. Logs can contain sensitive data — confirm that sending them is
> acceptable for your site.
