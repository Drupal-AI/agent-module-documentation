# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **PHP 8.1** or newer.
- No third-party Composer packages or front-end libraries.
- The optional **Dead Letter Queue UI** submodule additionally requires the
  **Queue UI** module (`queue_ui`, version 3.0 or later). The optional **Dead
  Letter Queue Unique** submodule requires the **Queue Unique** module.

## Install with Composer

From the project root:

```bash
composer require drupal/dead_letter_queue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dead_letter_queue -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dead_letter_queue -y
```

## Submodules

Enable these only if you need them:

| Submodule | Machine name | What it adds | Also requires |
|-----------|--------------|--------------|---------------|
| **Dead Letter Queue UI** | `dead_letter_queue_ui` | Integrates with Queue UI to list dead letters per queue and reset an item's tries, at `/admin/config/system/queue-ui/dead-letters/{queueName}`. Gated by the `admin queue_ui` permission. | Queue UI (`queue_ui`) ≥ 3.0 |
| **Dead Letter Queue Unique** | `dead_letter_queue_unique` | A unique-item (deduplicating) dead-letter queue for the Queue Unique module. | Queue Unique (`queue_unique`) |

For example, to add the inspection UI:

```bash
drush en dead_letter_queue_ui -y
```

## Verify it worked

Confirm the module is enabled (`drush pml | grep dead_letter_queue`). The real
proof is functional: point a queue at the dead-letter backend, set a low
`max_tries`, and let a deliberately failing worker run — after the threshold is
reached, cron should stop re-serving that item. If you enabled the UI submodule,
the dead item should appear at
`/admin/config/system/queue-ui/dead-letters/{queueName}`. See
[How to use it](../index.md#how-to-use-it) in the main guide for the wiring
details.
