# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it.
- The **Key** module (`key`) — used to store the DeepL API key securely instead
  of in plain configuration.
- A **DeepL API account**. DeepL offers a **Free** and a **Pro** API plan; each
  gives you an authentication key. (Note the DeepL *API* plans are distinct from
  the consumer subscription — you need an API key.)

There are no additional PHP library requirements. Be aware this is an **alpha**
release (1.0.0-alpha3) — review before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_deepl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` and
`key` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_deepl -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_deepl -y
```

Drupal enables the `ai` and `key` modules automatically as dependencies if they
are not already on. This module ships no submodules. Continue to
[Configuration](../configuration/index.md).
