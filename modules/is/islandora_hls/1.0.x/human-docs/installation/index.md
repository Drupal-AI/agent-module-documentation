# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Islandora** module (`islandora`) and a working Islandora stack.
- The media-processing tooling in your Islandora stack that actually produces HLS
  segments from audio/video (Islandora sites typically run these transcoding
  microservices alongside Drupal). Consult the module's `README` and your Islandora
  deployment (for example an isle-buildkit stack) for the exact service.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora_hls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Islandora and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora_hls -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora_hls -y
```

Drupal enables the Islandora dependency at the same time if it is not already on.

## Verify it worked

After configuring an Islandora derivative action/context to generate HLS (see the
overview page), ingest or re-derive an audio or video object and confirm an HLS
derivative is produced and that the player streams it rather than downloading the
whole file. Because this is an **alpha** release, test on a non-production copy first.
