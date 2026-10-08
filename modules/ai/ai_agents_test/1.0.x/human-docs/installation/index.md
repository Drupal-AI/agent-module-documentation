# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Agents** module (`ai_agents`) — the agents these tests exercise.
  Through it you will also have the base **AI** module and a configured AI
  provider (API key held in a Key entity / environment variable).
- Core's **Views**, **Options** and **User** modules (Views powers the test list).

This is an **experimental**, alpha release (1.0.0‑alpha4) — expect the test entity
and runner to keep changing.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_agents_test -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI Agents dependency and
updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_agents_test -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_agents_test -y
```

After enabling, grant the **view** and **edit** `ai_agents_test` permissions to
your test authors and keep the restricted **administer** permission for framework
administrators, then start creating test entities.
