# Installation

## Requirements

Responsive Voice Text to Audio needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (`node`), enabled automatically as a dependency.
- A **ResponsiveVoice API key**. You obtain this from the service provider at
  <https://app.responsivevoice.org/>. Speech is synthesized by ResponsiveVoice's
  external service, so an account/key is required — see the privacy note on the
  [overview page](../index.md).

There are no third‑party Composer or PHP library requirements; the
ResponsiveVoice.js library is loaded from the service at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_voice_tts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_voice_tts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_voice_tts -y
```

## Verify it worked

Go to **Configuration → Web Services → Responsive Voice TTS Settings** and confirm
the settings form is present. Once you've configured it and placed the block (see
[Configuration](../configuration/index.md)), view a page of a selected content
type — a **"Listen to this content"** button should appear, and clicking it (or
pressing **Shift + P**) should read the content aloud.
