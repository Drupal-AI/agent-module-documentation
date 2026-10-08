# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenAI provider** for the AI module (`ai_provider_openai`) — a required
  dependency, configured with a working API key (managed via the AI provider
  layer and the Key module).
- **Drush 9 or newer**, and the **`nikic/php-parser`** library (`^5.3`) — these
  are developer requirements the tool uses to parse PHP files. Installing the
  module with Composer pulls the library in.

This is a CLI‑only developer utility — run it only in a trusted developer
environment, since it reads arbitrary local file paths and sends their contents
to the AI provider.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_refactor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the OpenAI provider and `nikic/php-parser`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_refactor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_refactor -y
```

## After enabling

Confirm the **OpenAI provider** is configured in the AI module with a working key
stored as a Key. Then run the analyze command against a file you are permitted to
share:

```bash
drush ai_refactor:analyze /path/to/File.php
```

See the [overview](../index.md) for what the command does and its `ma:analyze`
alias.
