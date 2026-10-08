# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** (`options`) and **System** (`system`) modules — both are part
  of Drupal core, and Drupal enables them as dependencies automatically.
- No third‑party Composer packages beyond core.

**Recommended companions** (optional, not required): a robust cron runner such as
[Ultimate Cron](https://www.drupal.org/project/ultimate_cron) helps the queue
drain reliably, and mail modules like Symfony Mailer / MailSystem can shape how
messages are actually sent.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_entity_queue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_entity_queue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_entity_queue -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Mail entity
queues** (`/admin/config/system/mail-entity-queue`). You should be able to add a
queue there. See [Configuration](../configuration/index.md) for creating your
first queue and understanding how items are added and processed.
