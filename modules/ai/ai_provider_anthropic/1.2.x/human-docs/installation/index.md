# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** (AI Core) module (`drupal/ai`, `^1.2.0`) — Anthropic Provider is a
  plugin for it and cannot work alone.
- The **Key** module (`drupal/key`, `^1.18`) — used to store your Anthropic API
  key securely as a Key entity.
- An **Anthropic API key** — create one in the Anthropic Console at
  `https://console.anthropic.com/settings/keys`. You'll add it as a Key entity
  during configuration.

Composer pulls in the AI and Key modules for you.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_anthropic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required **AI** and **Key** modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_anthropic -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_anthropic -y
```

This enables Anthropic Provider along with **AI** and **Key** if they aren't
already on. You can also enable them from **Extend** (`/admin/modules`).

## Store your API key as a Key entity

Keep the secret out of configuration and version control. The recommended pattern
(matching this project's conventions) is to put the key in an environment variable
and reference it with an env‑based Key:

```bash
drush key:save anthropic_api_key --label='Anthropic API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"ANTHROPIC_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You can also create the Key through the UI at **Configuration → System → Keys**.
Either way, you'll select this Key on the provider settings form.

## Next steps

Point the provider at your Key, decide on moderation, and make Anthropic AI Core's
default provider — see [Configuration](../configuration/index.md).
