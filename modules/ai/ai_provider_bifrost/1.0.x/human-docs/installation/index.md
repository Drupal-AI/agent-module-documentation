# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- The **AI** module (`ai`, version **1.4 or newer**) — this provider is a plugin
  for it and does nothing on its own.
- The **Key** module (`key`, version **1.18 or newer**) — used to store the
  gateway credential securely instead of in plain configuration.
- A reachable **Bifrost gateway** with a URL and an access credential.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_bifrost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` and
`key` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_bifrost -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_bifrost -y
```

Drupal enables the `ai` and `key` modules automatically as dependencies if they
are not already on.

This module ships no submodules. Once enabled, continue to
[Configuration](../configuration/index.md) to register the gateway and its
credential.
