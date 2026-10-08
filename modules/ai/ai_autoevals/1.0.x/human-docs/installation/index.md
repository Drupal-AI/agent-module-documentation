# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) with an AI provider configured — this runs the
  evaluations. Its API key must be stored via a Key entity backed by an environment
  variable, never in plain config.
- The **Key** module (`key`), used to hold the provider's key.

This is an **alpha** release (1.0.0‑alpha2).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_autoevals -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI and Key dependencies and
updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_autoevals -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_autoevals -y
```

After enabling, grant the AI AutoEvals permissions to your QA/admin roles and make
sure your AI provider is configured — remember each evaluation calls the provider
and incurs cost.
