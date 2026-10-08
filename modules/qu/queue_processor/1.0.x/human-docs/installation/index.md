# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3 or higher**.
- Core's **System** module (always present).

No additional contrib modules or external libraries are required. The **Queue UI**
module is optional but recommended — when present, Queue Processor discovers your
queues automatically and offers a checkbox interface instead of hand‑typed queue
names.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/queue_processor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_processor -y
```

Automatic queue processing is **on by default** the moment the module is enabled.

## Verify it worked

Log in as an administrator and open **Configuration → System → Queue Processor**
(`/admin/config/system/queue-processor`) — you should see the settings form with
the global options and a section for each discovered queue. To confirm processing is
happening, browse the front end for a moment, then check **Reports → Recent log
messages** (`/admin/reports/dblog`) filtered by type **queue_processor**. See the
"Configure it" section of the [overview](../index.md) for how to tune priorities and
time limits.
