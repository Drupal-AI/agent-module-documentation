# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- Core **Options** (`options`) and **User** (`user`) — enabled automatically as
  dependencies.
- A **sending** library or module (for example Firebase PHP or APNs PHP) if you
  actually want to deliver notifications — this module only stores and manages
  tokens.
- Optionally, the **Universal Device Detection** module if you want to log the
  device user agent when a token is added.

## Install with Composer

From the project root:

```bash
composer require drupal/push_notifications_registration_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/push_notifications_registration_tokens -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en push_notifications_registration_tokens -y
```

## Verify it worked

1. Confirm the module is enabled and the **registration-token entity type** is
   available.
2. Save a test token through the module's **JSON-RPC endpoint** (including its
   type — `android`, `apple`, or `web`) and confirm it is stored.
3. Review the retention behavior (the 90-day auto-deletion default) and adjust it
   only if you have a deliberate reason — see "How to use it" in the
   [overview](../index.md).
