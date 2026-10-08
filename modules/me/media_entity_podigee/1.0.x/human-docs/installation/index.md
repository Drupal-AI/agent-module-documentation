# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: >=10`).
- Drupal core's **Media** module (`media`).
- The **oEmbed Providers** module (`oembed_providers`) — a required contrib
  dependency that lets you register Podigee as a custom oEmbed provider. Composer
  pulls it in automatically with the command below.
- A **Podigee account** with published episodes, so you have URLs to embed.

There are no third‑party PHP libraries to install. Note that a Drupal core patch
may currently be needed for Podigee thumbnails — check the module's project page.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_podigee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in oEmbed Providers
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_podigee -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_podigee -y
```

Core's Media module and the oEmbed Providers module are enabled automatically as
dependencies if they are not already on.

## Verify it worked

Go to **Configuration → Media → oEmbed Providers → Custom providers**
(`/admin/config/media/oembed-providers/custom-providers`) and confirm the custom
providers screen is available — this is where you register Podigee. Then check
**Structure → Media types → Add media type** (`/admin/structure/media/add`) for a
**Podigee** option in the **Media source** dropdown. Full step‑by‑step setup,
including the exact provider values, is in the [main guide](../index.md).
