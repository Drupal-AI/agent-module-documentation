# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it and does nothing on
  its own.
- A **ByteDance ModelArk** account with an API key (via Volcano Engine).

Storing the key through the **Key** module is strongly recommended (see
Configuration), and installing Key is the project convention even though it is not
a hard dependency of this module. There are no additional PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_bytedance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` module
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_bytedance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_bytedance -y
```

Drupal enables the `ai` module automatically as a dependency if it is not already
on. This module ships no submodules. Continue to
[Configuration](../configuration/index.md).
