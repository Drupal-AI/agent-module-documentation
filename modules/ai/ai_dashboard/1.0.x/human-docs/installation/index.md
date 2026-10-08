# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- Three contrib modules, all pulled in automatically by Composer:
  - **AI** (`drupal/ai`, `^1.2`) — the AI ecosystem this dashboard is a front end for.
  - **Dashboard** (`drupal/dashboard`, `^2.0`) — provides the dashboard entity the page
    is built from.
  - **Project Browser** (`drupal/project_browser`, `^2.0`) — powers the recommended AI
    recipes ("Features") block.

There are no third‑party PHP library requirements. Outbound HTTP access to
`git.drupalcode.org` is needed for the recommended‑recipes feed.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the shared
dependencies — AI, Dashboard, and Project Browser — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_dashboard -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_dashboard -y
```

Enabling it also enables AI, Dashboard, and Project Browser as dependencies, installs
the `ai_dashboard` dashboard entity, and registers the recommended‑recipes source. AI
Dashboard ships no submodules.

## Verify it worked

Log in as a user with the **Administer AI** permission and visit **Configuration → AI**
(`/admin/config/ai`). Instead of a plain menu of links you should see the dashboard with
its Setup, Features, Status, Extensions, Configuration, and Documentation blocks. Next,
head to [Configuration](../configuration/index.md) to add a provider and (optionally)
customize the dashboard.
