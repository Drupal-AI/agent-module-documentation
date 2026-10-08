# Migrate Utils — manual setup guide

**Migrate Utils** (`migrate_utils`) is a small developer helper for Drupal core's
Migrate module. Its job is to record — in Drupal state — whether a migration is
currently running, and which one. Other code on your site can then check that
state and behave differently while a migration is in progress.

Why is that useful? During a large import you often want to *pause* work that
would otherwise fire on every entity save: expensive derivative builds, search
re-indexing, cache rebuilds, outbound notifications, or synchronisation to another
system. Left unchecked, those can slow a migration to a crawl or, worse, trigger
re-entrant processing on the very entities the migration is creating. Migrate
Utils gives your custom code a reliable "are we migrating right now?" signal so it
can skip that work until the import finishes.

It works by subscribing to the four Migrate lifecycle events. On pre-import and
pre-rollback it sets a "migration running" flag and stores the active migration
id; on the matching post events it clears them. You then read that state from your
own code. The module ships **no routes, no permissions, no configuration, and no
UI** — it is purely an API, and there is nothing to set up beyond installing and
enabling it. It depends only on Drupal core's **Migrate** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings and no
admin UI. You consume it from code, described below.

## Where it lives in the admin menu

Migrate Utils adds nothing to the admin menu — no page, block, or permission. It
is an API you call from your own module's code.

## How to use it

There are two ways to read the migration state from custom code.

**From procedural code (a hook):** use the static convenience class.

```php
use Drupal\migrate_utils\MigrateState;

if (MigrateState::isMigrationRunning()) {
  // e.g. skip notifications or heavy derivative work
  $id = MigrateState::getActiveMigrationId();
}
```

**From a service (dependency injection):** inject the event subscriber and call
its method.

```php
public function __construct(
  private readonly \Drupal\migrate_utils\EventSubscriber\MigrateEventSubscriber $migrateSubscriber,
) {}

// ...
if ($this->migrateSubscriber->isMigrationRunning()) {
  // ...
}
```

Both read the same two underlying Drupal state keys
(`migrate_utils.migration_running` and `migrate_utils.active_migration`), so they
always agree. The "running" flag is TRUE during both imports *and* rollbacks; use
`getActiveMigrationId()` when you need to know which migration is active. A
typical use is to guard a `hook_entity_presave` or `hook_ENTITY_TYPE_insert` so
its expensive logic is skipped while content is being migrated.
