# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **answers_core** submodule (bundled with this project), which the top‑level
  Answers module depends on for its core functionality.

> **Note:** this project's release is a development version (`2.0.x-dev`), so test
> it thoroughly before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/answers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The `answers_core` submodule ships inside the same project,
so Composer downloads it along with the main module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/answers -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en answers -y
```

Enabling **answers** pulls in its required **answers_core** submodule
automatically. After enabling, grant the Q&A permissions under **People →
Permissions** so the right roles can ask, answer, and vote.

## Submodule

| Submodule | Machine name | What it provides |
|-----------|--------------|------------------|
| **Answers Core** | `answers_core` | The core Q&A functionality that the main Answers module builds on. It is a required dependency, enabled for you when you enable Answers. |
