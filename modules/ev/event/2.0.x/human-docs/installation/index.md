# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Datetime Range** module (`datetime_range`), which supplies the event date
  fields. Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/event -W
```

The `-W` (`--with-all-dependencies`) flag is **important here, not just polite**: the
module depends on a core machine-name patch being applied during the Composer run,
and that patch may be skipped if you install without `-W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/event -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en event -y
```

Drupal enables Datetime Range automatically as a dependency.

## Verify it worked

Visit **People → Permissions** (`/admin/people/permissions`) and confirm the Event
permissions appear, then grant the create/edit rights you need. Head to **Content**
and confirm you can add a new Event. See
[How to use it](../index.md#how-to-use-it) for next steps.
