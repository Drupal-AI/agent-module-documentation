# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- The **AI** module (`ai`) with a configured provider — the extractor calls the
  AI module's structured-chat output, so you need a working provider whose API
  key is stored as a **Key** entity (see the note below).
- Core **User**, **System** and **Options** modules (standard on any site).
- **JSON Field** (`json_field`) and **Dynamic Entity Reference**
  (`dynamic_entity_reference`) — both are contrib modules Composer will pull in.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_entity_intake -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the JSON Field
and Dynamic Entity Reference dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_entity_intake -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_entity_intake -y
```

This also enables the AI module and the two contrib dependencies if they are not
already on.

## Optional submodules

AI Entity Intake ships submodules that extend intake support to more entity
types. Enable only the ones you need:

| Submodule | Adds intake support for |
|-----------|-------------------------|
| `ai_entity_intake_commerce` | Commerce products |
| `ai_entity_intake_group` | Group content |
| `ai_entity_intake_media` | Media entities |
| `ai_entity_intake_paragraphs` | Paragraphs |
| `ai_entity_intake_profile` | User Profile entities |
| `ai_entity_intake_taxonomy` | Taxonomy terms |

For example:

```bash
drush en ai_entity_intake_taxonomy -y
```

Each submodule requires the base module, which is already present once you have
installed it above, plus the relevant contrib module (Commerce, Group, Media,
Paragraphs or Profile) for its target.

## Storing the provider API key safely

The extractor runs through the AI module's provider layer, which needs an API
key. Keep it out of version control and plain config: save the value into an
environment variable (for example `ddev dotenv set .ddev/.env
--openai-api-key=<value>`, then `ddev restart`), create a **Key** entity that
reads from that variable, and point your AI provider at that key.
