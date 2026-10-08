# Installation

## Requirements

AI Monitoring needs the AI framework and secure key storage:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — enabled and configured with a working AI provider,
  which performs the log-severity analysis.
- The **Key** module (`key`) — required, so the AI API key is stored as a secret
  rather than in plain configuration.

There are no extra PHP libraries to install. To use the Slack or webhook
channels you'll need a destination URL (a Slack incoming webhook, or any endpoint
that accepts your POST), but those are configured later, not installed.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_monitoring -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the AI and Key modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_monitoring -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_monitoring -y
```

Drupal enables `ai` and `key` as dependencies if they are not already on.

## After enabling

1. Confirm the **AI** module has a provider configured, with its API key stored
   as a **Key** entity (per this project's conventions, back the Key with an
   environment variable set through DDEV's dotenv command).
2. Grant the module's permissions: **Administer AI Monitoring** to administrators,
   and **View AI Monitoring dashboard** / **View AI Monitoring alerts** to the
   people who should see the reports.
3. Head to [Configuration](../configuration/index.md) to pick the provider/model,
   define the routing matrix, and set up the alert channels.
