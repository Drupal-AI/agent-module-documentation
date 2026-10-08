# Installation

## Requirements

AI Model Registry is intentionally lightweight — it stores metadata and calls no
provider, so it has almost no dependencies:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **System** module (`system`) — the only dependency, always present.

It does **not** require the AI module itself, because it never makes AI calls; it
is a catalogue that other AI modules read. There are no third-party PHP libraries
to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_model_registry -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_model_registry -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_model_registry -y
```

On install it seeds four example model records (OpenAI, two Ollama, and LM
Studio) as default configuration, so the catalogue is not empty when you first
open it.

## After enabling

Grant the **Administer AI Model Registry** permission (`administer
ai_model_registry`) to the administrators who should curate the catalogue, then
open **Configuration → AI → AI Model Registry** to review the seeded entries and
add your own. See [Configuration](../configuration/index.md) for a tour of the
fields.
