# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Token** module (`token`) — the only dependency; the tokens are
  implemented on top of it.

There is no AI provider or API key requirement: despite the name, this module
only produces text tokens and makes no calls to any AI service. It is aimed at
*supplying* context to AI prompts elsewhere, not at calling a model itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_dr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_dr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_dr -y
```

This also enables the Token module if it is not already on. There is no
configuration step — the `[term:description]` and
`[node:term-description:FIELD_NAME]` tokens are available immediately.
