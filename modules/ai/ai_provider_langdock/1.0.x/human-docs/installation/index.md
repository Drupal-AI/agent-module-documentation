# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it and does nothing on
  its own.
- A **Langdock** account with an API key.

The module's only hard dependency is the AI module. Storing the API key through
the **Key** module is strongly recommended and is the project convention (see
Configuration), so install Key if it is not already present. There are no
additional PHP library requirements. Note this is a **beta** release
(1.0.0-beta1).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_langdock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` module
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_langdock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_langdock -y
```

Drupal enables the `ai` module automatically as a dependency if it is not already
on. This module ships no submodules. Continue to
[Configuration](../configuration/index.md).
