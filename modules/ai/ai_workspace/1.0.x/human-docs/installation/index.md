# Installation

## Requirements

- **Drupal 10.4+ or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **User** and **System** modules (always present).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working AI provider and the models you want to offer — this is what powers
  the chat.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_workspace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_workspace -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_workspace -y
```

This ensures the `ai` module is enabled too. Then grant the workspace permissions
to the appropriate roles (see the overview) before staff start using it.

> **Note:** this release is a release candidate (1.0.0‑rc4). Test before relying
> on it in production.
