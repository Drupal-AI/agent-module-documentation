# Installation

## Requirements

- **Drupal 10.5, 11 or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- The **AI** module (`ai`) — this provider is a plugin for it.
- The **Cloudflare AI** module (`cloudflare_ai`) and the **Cloudflare SDK**
  module (`cloudflare_sdk`), which this provider builds on. Composer pulls these
  in automatically.
- A **Cloudflare account** with an **AI Gateway** created, and an API token that
  can use it.

There are no additional PHP library requirements beyond what the Cloudflare SDK
module brings.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_cloudflare_gateway -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai`,
`cloudflare_ai` and `cloudflare_sdk` modules and update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_cloudflare_gateway -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_cloudflare_gateway -y
```

Drupal enables the `ai`, `cloudflare_ai` and `cloudflare_sdk` modules
automatically as dependencies if they are not already on. This module ships no
submodules. Continue to [Configuration](../configuration/index.md).
