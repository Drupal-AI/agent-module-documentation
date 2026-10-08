# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
- The **Key module** (`drupal/key`) — holds the Google API key outside exported
  configuration.

Both dependencies are pulled in automatically by Composer. This is a **beta**
release (1.0.0‑beta1) — test before relying on it.

You will also need a **Google API key** with access to the Gemini image models
(Gemini 2.5 Flash Image / Gemini 3 Pro Image), created in
[Google AI Studio](https://aistudio.google.com/).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_nanobanana -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI and Key
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_nanobanana -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_nanobanana -y
```

This module ships no submodules. To actually generate images you will also want
an image‑capable consumer such as **NanoBanana Editor**. Next, add your Google
API key and register the provider in [Configuration](../configuration/index.md).
