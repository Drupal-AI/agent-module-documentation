# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) — a hard dependency;
  Auphonic is a provider for it.
- An **Auphonic account and API key**.

There are no additional Composer library or PHP requirements declared by the module.
Note that the current release is an early **beta** (1.0.0-beta3).

## Install with Composer

From the project root:

```bash
composer require drupal/auphonic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auphonic -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auphonic -y
```

Enabling it will also enable the AI module if it wasn't on already.

## Next steps

The module has no settings form of its own. Configure it as a provider inside the AI
module and supply your Auphonic API key — see
[How to use it](../index.md#how-to-use-it) for the credential-handling steps.
