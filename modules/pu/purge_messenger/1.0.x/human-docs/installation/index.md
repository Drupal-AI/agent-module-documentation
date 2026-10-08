# Installation

## Requirements

- **Drupal 10.5+ or 11.3+** (`core_version_requirement: ^10.5 || ^11.3`).
- The **Purge** module (`purge`), set up and working.
- The **Symfony Messenger** module (`sm`), with at least one transport configured
  (Redis, RabbitMQ, SQS, etc.).
- Core **Serialization** (`serialization`) — enabled automatically as a
  dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_messenger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Purge, Symfony Messenger, and Serialization.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_messenger -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_messenger -y
```

Enabling the module does not switch anything over on its own — you still have to
change Purge's queue engine to **Messenger**. See "How to use it" in the
[overview](../index.md).

## Verify it worked

1. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
2. Under the **Queue** section, confirm **Messenger** is available as a queue
   engine and is selected.
3. Trigger a content change and confirm invalidation messages arrive on your
   Symfony Messenger transport (and are picked up by your workers).
