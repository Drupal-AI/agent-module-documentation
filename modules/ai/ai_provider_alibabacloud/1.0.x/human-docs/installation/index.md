# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`) — this provider is
  a plugin for it and does nothing on its own.
- The **[Key module](https://www.drupal.org/project/key)** (`key`) to hold your
  API key securely. It comes in through the AI module's requirements; if it is not
  already present, add it as shown below.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_alibabacloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the AI
and Key modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_alibabacloud -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_alibabacloud -y
```

Enabling it will also enable the AI and Key modules if they are not on yet. The
module ships no submodules.

Once enabled, continue to [Configuration](../configuration/index.md) to add your
Alibaba Cloud Model Studio credentials — the provider does nothing until it has an
API key.
