# Installation

## Requirements

- **Drupal 10.1 or later, 11, or 12** (`core_version_requirement: ^10.1 || ^11`).
- The **Islandora** module (`islandora`) and a working Islandora stack.
- The **Context** module (`context`).
- The **Islandora Text Extraction** module (`islandora_text_extraction`).
- For **automatic** VTT generation, the **scyllaridae OpenAI Whisper** microservice
  available in your Islandora stack. Without it you can still attach VTT files you
  produce yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora_vtt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required modules
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora_vtt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora_vtt -y
```

Drupal enables the Islandora, Context, and Islandora Text Extraction dependencies at
the same time if they are not already on.

## Verify it worked

Attach a VTT file to an audio/video media's node as an *extracted text* media type,
then view that object. You should see the transcript rendered beside the player,
with a keyword search box and clickable timestamps that seek the player. If you have
wired up the Whisper microservice, ingest a new A/V object and confirm a VTT
transcript is generated automatically.
