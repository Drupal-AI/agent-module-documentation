# Installation

## Requirements

Queue Mail needs only Drupal core:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- A working **cron** — queued mail is sent when cron runs, so make sure cron is
  scheduled (or you process the queue manually, see below).

There are no third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/queue_mail -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_mail -y
```

Or enable **Queue Mail** from **Extend** (`/admin/modules`). Enabling the module
creates the `queue_mail` queue automatically, but **queues nothing** until you list
mail IDs on the settings form — see [Configuration](../configuration/index.md).

## Submodule — Queue Mail Language

Queue Mail ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Queue Mail Language** | `queue_mail_language` | Makes each queued message send in its own language when it is finally delivered, rather than the site's active language at send time. Enable it if you send localized mail. |

```bash
drush en queue_mail_language -y
```

## Processing the queue

Queued mail is sent on **cron**. If you want to flush the queue on demand, use core's
Drush queue runner (Queue Mail adds no command of its own):

```bash
drush queue:run queue_mail --time-limit=15
```

Always pass `--time-limit` — because failed sends are re‑queued, an unbounded run may
not terminate cleanly.
