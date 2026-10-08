# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it.
- The **Key** module (`key`) — used to store the Google service-account
  credential securely instead of in plain configuration.
- A **Google Cloud** project with the **Vertex AI API** enabled and a
  **service-account** JSON key that can call it.

There are no additional PHP library requirements listed for the module itself;
your Google Cloud project must, of course, have Vertex AI enabled and billing
configured.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_google_vertex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` and
`key` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_google_vertex -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_google_vertex -y
```

Drupal enables the `ai` and `key` modules automatically as dependencies if they
are not already on. This module ships no submodules. Continue to
[Configuration](../configuration/index.md).
