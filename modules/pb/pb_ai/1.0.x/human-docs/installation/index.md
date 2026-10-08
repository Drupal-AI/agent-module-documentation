# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal's **Project Browser** experience (this module improves its search).
- Access to an **AI provider** and an **API key** for it, since smart search calls
  out to an LLM.

This is a **beta** (1.0.0-beta2) release and is minimally maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/pb_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pb_ai -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pb_ai -y
```

## Verify it worked

Log in as an administrator, connect an AI provider and API key (see
[Configuration](../configuration/index.md)), then open the Project Browser and try a
natural-language search. Relevant modules should surface even when your wording does
not exactly match their names.
