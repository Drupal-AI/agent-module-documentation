# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No required module dependencies and no third-party Composer libraries.
- A **working outgoing mail setup** on your site — Email confirmer sends the
  confirmation links through Drupal's mail system, so mail must actually be
  delivered for it to be useful.

Optional but suggested:

- **[Queue Unique](https://www.drupal.org/project/queue_unique)** — provides
  queues that only accept unique items, which pairs well with the resend queue.
- **[Ultimate Cron](https://www.drupal.org/project/ultimate_cron)** — the module
  ships an optional cron job for scheduled cleanup of old confirmation records.

## Install with Composer

From the project root:

```bash
composer require drupal/email_confirmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_confirmer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_confirmer -y
```

## Submodule — confirm user email changes

The base module does not confirm anything by itself; it is an API other code calls.
To immediately put it to use, enable the bundled submodule that applies
confirmation to Drupal's user email-change flow:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Email confirmer (user)** | `email_confirmer_user` | Requires users to confirm a new email address (via a signed link) when they change it on their account. |

```bash
drush en email_confirmer_user -y
```

## Next steps

Head to [Configuration](../configuration/index.md) to tune link expiry, record
lifetime, resend delay, and the request-email wording, and to grant the module's
permissions.
