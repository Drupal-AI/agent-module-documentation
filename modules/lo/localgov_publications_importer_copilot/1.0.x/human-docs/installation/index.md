# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **LocalGov Publications Importer** (`localgov_publications_importer`) — this module
  is a transform plugin for that pipeline, so it must be present and enabled.
  Through it, you also need **LocalGov Publications** and a LocalGov Drupal site.
- A **Microsoft Copilot Studio** environment where you can import the bundled agent
  and obtain a **Direct Line** token endpoint. Formatting happens by calling
  Microsoft's Direct Line API over HTTPS, so the site needs outbound network access
  to it.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_publications_importer_copilot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install LocalGov Publications
Importer and shared dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_publications_importer_copilot -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_publications_importer_copilot -y
```

Enabling the module registers the **Copilot (all‑in‑one)** transform plugin and
installs the ready‑made **`copilot_pipeline`** import pipeline.

## Verify it worked

In LocalGov Publications Importer's **Import Pipelines** screen you should now see a
**Copilot** pipeline available to choose. Before it will actually format content you
must set up the Copilot Studio bot and its **token URL** — follow
[Configuration](../configuration/index.md).
