# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Layout Builder** module (`layout_builder`).
- The contrib **Content Lock** module (`content_lock`) — this is where the actual
  entity-edit locking comes from; Lock Layout Builder makes Layout Builder honor
  it.

## Install with Composer

From the project root:

```bash
composer require drupal/lock_layout_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Content Lock and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lock_layout_builder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lock_layout_builder -y
```

Drupal will enable Layout Builder and Content Lock as dependencies if they aren't
already on.

## Configure Content Lock

Lock Layout Builder itself needs no configuration, but the underlying **Content
Lock** module does decide which entity types are lockable. Visit **Configuration →
Content authoring → Content lock** (`/admin/config/content/content_lock`) and enable
locking for the entity types whose layouts you want protected.

## Verify it worked

Enable Layout Builder on a content type, then open one entity's **Layout** tab as
User A (this takes the content lock). As User B (a different account, e.g. in
another browser), open the same entity's layout — the section and block operations
should be blocked for User B until User A's lock is released.
