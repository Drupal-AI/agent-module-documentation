# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** (`block`) and **JSON:API** (`jsonapi`) modules.
- The contributed **JSON:API Views** module (`jsonapi_views`), which Composer
  pulls in for you.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupalorg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in JSON:API Views
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalorg -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalorg -y
```

Drupal enables the Block, JSON:API, and JSON:API Views dependencies
automatically when you turn on Drupal.org.

## Verify it worked

After enabling, check **People → Permissions** — you should see the module's
workflow permissions (such as *manage security releases*) listed. Remember that
this module reproduces drupal.org's own customizations, so on any other site its
value is mostly as a reference; there is nothing further to configure for general
use.
