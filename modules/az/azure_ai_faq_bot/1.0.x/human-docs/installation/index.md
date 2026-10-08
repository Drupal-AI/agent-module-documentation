# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- An **Azure Cognitive Services** resource (a language/QnA service) with an
  endpoint and access key. You create this in the Azure portal; it is a paid
  Microsoft service.

There are no third‑party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_ai_faq_bot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_ai_faq_bot -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_ai_faq_bot -y
```

Enabling the module does **not** make the bot work on its own — you still need to
supply your Azure credentials and place the chat block. See
[Configuration](../configuration/index.md).
