# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Media** module (`media`) — Drupal enables it automatically as a
  dependency.
- **An AI provider** capable of image/vision analysis, configured through
  Drupal's AI ecosystem. AltTexting sends images to this provider to generate
  suggestions, so you need a working provider with valid credentials.
- **An API key** for that provider. Store it as a **secret** — use a Key entity
  backed by an environment variable rather than pasting it into configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/alttexting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/alttexting -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alttexting -y
```

After enabling, configure your AI provider (if you have not already) and grant
the module's alt-text permission to the roles that should be able to generate
suggestions. Remember that generated text should always be reviewed by a person
before it is saved.
