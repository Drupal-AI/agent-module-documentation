# Installation

## Requirements

- **Drupal 10.4, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- The **AI** module (`ai`) with a configured provider — the evaluations run
  through it.
- A configured AI **provider** whose API key is stored as a **Key** entity (see
  below).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_empathy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_empathy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_empathy -y
```

This also enables the AI module if it is not already on.

## After enabling

Grant the module's permissions — **Administer AI empathy**, **Run AI empathy
evaluation**, and the view/rate results permissions — to the appropriate roles,
and make sure your AI provider's API key is stored securely: save it in an
environment variable, wrap it in a **Key** entity, and point the provider at that
key. See [How to use it](../index.md#how-to-use-it) in the overview.
