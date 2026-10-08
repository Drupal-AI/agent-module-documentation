# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Block** and **Views** modules enabled — these are the declared
  dependencies and the systems AI CIJO orchestrates.
- A working **AI provider** configured through the
  [AI](https://www.drupal.org/project/ai) module. Intent detection runs through
  that provider, so it needs to be set up with valid credentials even though the
  provider is not listed as a hard module dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_cijo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_cijo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_cijo -y
```

Grant the **Administer AI CIJO** permission (`administer ai cijo`) to the users
who should set up journeys, then configure your journeys as described in
[How to use it](../index.md#how-to-use-it).

## A note on secrets

Intent detection sends data to your AI provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects.
