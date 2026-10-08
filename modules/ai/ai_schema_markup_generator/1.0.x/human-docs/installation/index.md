# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal's **AI** module, configured with a working **AI provider** and its API
  key stored via the **Key** module. This provider generates the schema markup.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_schema_markup_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_schema_markup_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_schema_markup_generator -y
```

## After enabling

1. Make sure an **AI provider** is configured in the AI module, with its API key
   stored as a Key (env‑backed), not in plain configuration.
2. At **People → Permissions**, grant the module's permission to the roles that
   should be able to generate schema markup.
3. Generate schema for your content and **review the JSON‑LD before publishing**
   — incorrect structured data can harm SEO. Note that the page content is sent
   to your AI provider.
