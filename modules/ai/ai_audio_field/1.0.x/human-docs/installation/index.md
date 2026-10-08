# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) with an AI provider configured — this supplies the
  audio/transcription capability. Its API key must be stored via a Key entity
  backed by an environment variable, never in plain config.
- Core's **File** module (`file`), which stores the audio files.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_audio_field -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI dependency and updates
shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_audio_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_audio_field -y
```

Once enabled, add the AI Audio Field to a content type under **Structure →
(content type) → Manage fields**. It has no separate settings page — you configure
it per field.
