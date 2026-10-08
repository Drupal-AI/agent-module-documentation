# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`).
- The **AI** module (`ai`) — Drupal's AI framework.
- The **NanoBanana AI provider** module (`ai_provider_nanobanana`) — this supplies
  the connection to the NanoBanana/Gemini image service and holds the API key.
- An API key for the NanoBanana AI provider (you will add it during configuration).

The AI and provider modules are hard dependencies, so Composer will pull them in
alongside NanoBanana Editor.

## Install with Composer

From the project root:

```bash
composer require drupal/nanobanana_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the AI module,
the provider module, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nanobanana_editor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nanobanana_editor -y
```

This also enables `media`, `ai`, and `ai_provider_nanobanana` if they are not
already on.

## Set up the AI provider

Before the editor can do anything, the **NanoBanana AI provider** must be
configured with a valid API key. See [Configuration](../configuration/index.md)
for how to store that key securely and point the provider at it.

## Verify it worked

Go to **Content → Media → Add media → Image**. You should see a **Generate with
NanoBanana** button. On an existing media image's edit form you should see **Edit
with NanoBanana**. If those buttons are missing, confirm the AI provider is
enabled and configured with a working key.
