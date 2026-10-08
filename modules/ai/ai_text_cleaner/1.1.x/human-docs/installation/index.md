# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) enabled, with at least one **AI provider** configured
  and a valid provider API key stored as a secret (a Key entity or an
  environment variable — never in plain configuration).

There are no additional third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_text_cleaner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the AI module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_text_cleaner -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_text_cleaner -y
```

## Set up the AI provider

This module does nothing until the AI module has a working provider. If you have
not already done so:

1. Enable and configure the **AI** module and a provider module under
   **Configuration → AI** (`/admin/config/ai`).
2. Store the provider API key as a secret — a **Key** entity backed by an
   environment variable is the recommended pattern; never paste the key into
   plain configuration.

Running the cleaner sends text to that provider, so confirm the egress is
acceptable for the content involved.
