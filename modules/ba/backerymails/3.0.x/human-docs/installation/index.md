# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- Core's **Views** module (`views`).
- The contributed **Mail System** module (`mailsystem`) — Backery Mails registers as a
  mail plugin that you select through Mail System's settings.

## Install with Composer

From the project root:

```bash
composer require drupal/backerymails -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Mail System (if not already present)
and updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/backerymails -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en backerymails -y
```

This enables Views and Mail System too if they weren't already on. After enabling, you
need to route your mail through Backery Mails for it to capture anything — see
[Configuration](../configuration/index.md).
