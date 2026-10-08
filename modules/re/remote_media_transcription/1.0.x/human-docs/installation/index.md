# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  enabled automatically as dependencies.
- A **remote video** media type (Drupal's standard remote-video source, using
  oEmbed) to attach transcriptions to.
- No third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/remote_media_transcription -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remote_media_transcription -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remote_media_transcription -y
```

## Verify it worked

Grant the **Administer Remote Media Transcription** permission to your
administrator role, visit **Configuration → Media → Remote Media Transcription**
(`/admin/config/media/remote-media-transcription`) to confirm the settings form
loads, then edit a remote video media entity and confirm a **Video Transcription**
section is available. Add a transcription, save, and view the media — the
transcription should appear below the video with a toggle button.
