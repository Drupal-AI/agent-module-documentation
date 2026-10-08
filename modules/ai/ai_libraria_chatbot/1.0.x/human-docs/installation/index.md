# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other contrib module dependencies — the module is self-contained.
- A **Libraria.ai** account, where you build the chatbot and get its embed script.

There is no AI provider or API key to configure in Drupal: the AI runs inside the
Libraria-hosted widget, and the only value you store here is the embed snippet
Libraria gives you.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_libraria_chatbot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_libraria_chatbot -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_libraria_chatbot -y
```

There are no submodules. Next, paste your Libraria embed script and place the
block — see [Configuration](../configuration/index.md).
