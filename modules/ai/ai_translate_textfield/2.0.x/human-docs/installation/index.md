# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`), installed and configured with a working provider. The
  provider's API key must be stored as a secret (via the Key module or an
  environment variable) — this module relies on the AI module for the actual
  translation calls and for credential handling.
- A **multilingual** setup (core's Language and Content Translation modules) so
  there are target languages to translate into.

The AI module is enabled automatically as a dependency when you turn this module
on. There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_translate_textfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_translate_textfield -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_translate_textfield -y
```

After enabling, grant the module's permission to the appropriate roles under
**People → Permissions**, and confirm the AI module has a provider configured.
The AI translation action then becomes available on supported text fields in the
content-editing form.
