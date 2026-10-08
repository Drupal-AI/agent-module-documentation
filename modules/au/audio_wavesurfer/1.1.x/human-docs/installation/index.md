# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** (`media`) module, which Drupal enables automatically as a
  dependency.
- The player uses the **wavesurfer.js** JavaScript library; follow the project's
  README for how it expects the library to be provided.

## Install with Composer

From the project root:

```bash
composer require drupal/audio_wavesurfer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audio_wavesurfer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audio_wavesurfer -y
```

## Submodule — clip regions

**Audio Wavesurfer Clips** (`audio_wavesurfer_clips`) adds clip-region support on
top of the waveform player. Enable it only if you need it:

```bash
drush en audio_wavesurfer_clips -y
```

Then select the waveform player on an audio field's **Manage display** tab. See
[How to use it](../index.md#how-to-use-it).
