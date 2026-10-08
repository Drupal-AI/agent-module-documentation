# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — this module is a provider plugin for it.
- The **Key** module (`key`) — used to store your API key securely.
- An **ElevenLabs account and API key**. ElevenLabs offers free trials. When you
  create the API key, make sure it has access to **Text to Speech**,
  **Speech to Text**, **Audio Isolation**, **Users**, **Voices**, **Models**, and
  **History**.

Composer will pull in the AI and Key modules for you when you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/elevenlabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the AI and Key modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elevenlabs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elevenlabs -y
```

This also enables the **AI** and **Key** modules if they are not already on.

## Verify it worked

Go to **Configuration → System → ElevenLabs settings**
(`/admin/config/system/eleven-labs-settings`). The settings form should load,
ready for you to select the Key that holds your API credential — see
[Configuration](../configuration/index.md).
