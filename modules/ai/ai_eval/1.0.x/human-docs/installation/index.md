# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`) — this module requires a
  recent Drupal 11.
- The **AI** module (`ai`) with a configured provider — evaluations run through
  it.
- Core **Options** (`options`) and **File** (`file`) modules — used for the
  datasets and results.
- A configured AI **provider** whose API key is stored as a **Key** entity (see
  below).

This is a beta release (1.0.0-beta2), so test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_eval -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_eval -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_eval -y
```

This also enables the AI module and the core Options and File modules if they
are not already on.

## After enabling

Grant the module's permissions — **Operate AI eval**, **Administer AI eval**, and
the annotate/validate permissions — to the appropriate roles, and make sure the
AI provider's API key is stored securely: save it in an environment variable,
wrap it in a **Key** entity, and point the provider at that key. See
[How to use it](../index.md#how-to-use-it) in the overview.
