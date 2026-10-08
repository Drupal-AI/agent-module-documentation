# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **AI** module (`ai`) with providers configured for **speech‑to‑text**,
  **chat** and **text‑to‑speech** operations. Their API keys must be stored via a
  Key entity / environment variable, never in plain config.
- Core's **Media** module (`media`) — the source and result are `audio_file` media
  entities.
- Core's **Taxonomy** module (`taxonomy`) — you pick a vocabulary whose terms
  become the selectable target languages.

This is an early **release candidate** (0.1.0‑rc1).

## Install with Composer

Note that the Composer package name differs from the module's machine name — the
project is **`ai_audio_translate`**:

```bash
composer require drupal/ai_audio_translate -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the dependencies and updates
shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_audio_translate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The enabled module's machine name is `ai_audio_translator`:

```bash
drush en ai_audio_translator -y
```

## Next step

Open [Configuration](../configuration/index.md) to choose your language
vocabulary, set the translation prompt, and (optionally) override which AI
providers handle each step.
