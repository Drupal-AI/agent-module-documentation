# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10.0 || ^11`).
- The **AI** module (`ai`) with a provider that supports **text‑to‑speech**
  configured.
- The **Key** module (`key`) — holds the provider's API key. Store that key in an
  environment variable and expose it through a Key entity; never put it in plain
  config.
- Core's **Node**, **Media** and **File** modules — the source text comes from
  nodes and the generated MP3 is stored as a managed file / media item.

This is an **alpha** release (1.0.0‑alpha3).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_audio_generator -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI and Key dependencies and
updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_audio_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_audio_generator -y
```

After enabling, configure your voices and pronunciation dictionary, and grant the
generation permission only to trusted editors — each generation calls the AI
provider and incurs cost.
