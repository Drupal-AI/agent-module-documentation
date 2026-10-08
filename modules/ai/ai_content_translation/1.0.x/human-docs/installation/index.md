# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Translation** (`content_translation`) and **Configuration**
  (`config`) modules — both hard dependencies, enabled automatically. You will also
  want the site set up for multiple languages and your content types marked as
  translatable, which is standard core content-translation setup.
- An **OpenAI API key**. This module calls OpenAI directly (it does not use the
  shared Drupal AI module), so a valid key is required for any translation to work.

There are no third-party Composer or PHP library requirements.

### A note on the OpenAI API key

The module reads its OpenAI key from its own settings, but you should never paste a
secret straight into plain configuration or commit it to Git. On this project the
convention is to store the secret in an environment variable with DDEV's dotenv
command:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart
```

Prefer sourcing the key from that environment variable (for example via a Key
entity or `getenv('OPENAI_API_KEY')`) rather than typing it into a config field
that ends up in exported configuration. If you must enter it in the settings form,
treat your config exports as secret.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_translation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_translation -y
```

After enabling, set your OpenAI key in the module's settings, make sure your
languages and translatable content types are configured in core, and grant
**`administer ai content translation`** to the editors who should run
translations.
