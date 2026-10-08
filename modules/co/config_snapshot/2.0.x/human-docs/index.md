# Configuration Snapshot — manual setup guide

**Configuration Snapshot** (`config_snapshot`) is a developer API module. Its job
is to remember the configuration a module or theme *originally shipped*, so that
some other tool can later compare that baseline against your live site
configuration and see what has changed.

Think of it as a per-extension "as-provided" record. When a module installs, it
brings default configuration with it; over time editors and site builders tweak
that configuration on the live site. Configuration Snapshot captures the original
version as a snapshot and stores it inside Drupal's own configuration system, so
consumers can answer the question *"what has diverged from what this extension
provided?"* The best-known consumer is the
[Features](https://www.drupal.org/project/features) module, which uses snapshots
to detect when a feature's packaged configuration no longer matches the active
site.

Each snapshot is identified by three parts — a **snapshot set** (a namespace so
each consuming module keeps its own snapshots separate), an **extension type**
(module or theme), and an **extension name** — and is exposed through a full
implementation of core's standard storage interface. That means any code holding a
snapshot can read, write, and list its configuration exactly like any other
Drupal configuration storage, including per-language collections. The module also
registers a container service per existing snapshot for fast repeated access.

Because it is purely a building block, Configuration Snapshot has **no admin page,
no route, no settings, no permissions, and no Drush commands**. You install it
because another module depends on it, or because you are writing code that needs a
per-extension configuration baseline.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the snapshot config entity, the storage class,
the storage trait, and the service provider — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no menu item and no settings page. Configuration Snapshot is a
storage API consumed in code by other modules. Once enabled, its snapshot storage
classes and services are available to any module that needs them.

## How to use it

For most site builders, "using" it means installing it because a module you want
(such as Features) lists it as a dependency. For developers, you create a snapshot
storage for a given set/type/name, then read or write configuration through it
like any other storage — typically using the
`ConfigSnapshotStorageTrait::getConfigSnapshotStorage()` helper, which returns the
registered service when one exists or a fresh storage object as a fallback (useful
right after a new extension is installed, before the container rebuilds). The
snapshot is persisted as a `config_snapshot` config entity, so it exports cleanly.
The exact entity structure, storage methods, and service registration are
documented in the [`agent/`](../agent/start.md) references.
