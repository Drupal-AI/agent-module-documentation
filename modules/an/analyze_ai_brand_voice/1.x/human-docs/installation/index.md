# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Analyze** module (`analyze`, version 1.3.0 or later) — this module is a
  plugin on its Analyze tab.
- The **AI** module (`ai`) with a configured AI provider.
- **Views Color Scales** (`views_color_scales`, version 1.1.0 or later), used to
  present the analysis results.
- An **API key** for your AI provider. Store it as a **secret** — use an
  environment variable or a Key entity, not plain configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/analyze_ai_brand_voice -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Analyze, AI, and Views Color Scales.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/analyze_ai_brand_voice -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze_ai_brand_voice -y
```

After enabling, make sure your AI provider is configured with its key stored
securely. The brand-voice analysis then appears on the entity's **Analyze** tab.
Remember that analyzed content is sent to the AI provider — only run it on
content you are comfortable sharing.
