# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules or libraries outside Drupal core are required — the widget is
  framework-independent.

Note that this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/pnw -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pnw -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pnw -y
```

## Verify it worked

Log in as any authenticated user. A floating action button should appear over the
interface. Click it to open the notes modal, create a short note, confirm it lists
and paginates, then delete it — all without a page reload. Log in as a different
user to confirm each user only sees their own notes.
