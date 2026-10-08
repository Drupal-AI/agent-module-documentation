# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Checklist API](https://www.drupal.org/project/checklistapi)** module
  (`checklistapi`) enabled — this is what renders and tracks the checklist.

AI Checklist is a tracking aid, so it has no AI provider or API‑key requirements
of its own. (The steps it lists will, of course, guide you toward configuring
those in the AI modules.)

## Install with Composer

From the project root:

```bash
composer require drupal/ai_checklist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Checklist API and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_checklist -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_checklist -y
```

This pulls in Checklist API if it is not already on. After enabling, open the AI
setup checklist and start working through it — see
[Where it lives in the admin menu](../index.md#where-it-lives-in-the-admin-menu).
