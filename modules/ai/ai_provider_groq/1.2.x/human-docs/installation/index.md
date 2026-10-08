# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it.
- The **Key** module (`key`) — used to store the Groq API key securely instead of
  in plain configuration.
- A **Groq** account with an API key.

There are no additional PHP library requirements. Note this is a **release
candidate** (1.2.0-rc1).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_groq -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` and
`key` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_groq -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_groq -y
```

Drupal enables the `ai` and `key` modules automatically as dependencies if they
are not already on. This module ships no submodules. Continue to
[Configuration](../configuration/index.md).
