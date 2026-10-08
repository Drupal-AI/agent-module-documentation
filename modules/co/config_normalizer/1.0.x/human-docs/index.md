# Configuration Normalizer — manual setup guide

**Configuration Normalizer** (`config_normalizer`) is a developer library that
makes configuration comparisons trustworthy. When you diff two configuration
storages — say your site's active configuration against the exported files in the
sync directory — a lot of the differences that show up aren't real changes at
all. They're cosmetic: keys in a different order, a `uuid` or `_core` property
that Drupal sets automatically, or an export-only element that only exists in
files. Those false positives make it hard to tell whether configuration has
*actually* drifted.

Configuration Normalizer fixes that by "normalizing" each configuration item
before it is compared. It wraps any configuration storage in a **read-only
storage decorator** so that every item you read back comes out in a consistent,
canonical form — recursively sorted, with volatile core-set properties reconciled
against a reference, and export-only bits stripped out. Diff two normalized
storages and only the *meaningful* differences remain.

Under the hood it defines a `ConfigNormalizer` plugin type and ships three
plugins that run in order: one copies `uuid`/`_core` from the active store so
those don't register as differences, one recursively sorts arrays, and one strips
the export-only `roles` element from filter formats. A normalization "context"
controls whether the data is being prepared for comparison (the default, where
sorting is applied) or for writing back (where write-unsafe transforms are
skipped). A helper trait builds a core `StorageComparer` over two normalized
storages in one call.

This is infrastructure other tools build on — Configuration Update Manager,
Features, Config Distro and similar config tooling use it so their diffs are
accurate. It has **no admin page, no settings, no permissions, and no Drush
commands** of its own.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the three normalizer plugins, the read-only
storage decorator, the context array, and the comparer trait — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no menu item and no settings page. Configuration Normalizer is
a library consumed in code by other modules. Once enabled, its
`ConfigNormalizer` plugin type and its normalized storage classes are available
to any module that needs to compare configuration cleanly.

## How to use it

For most site builders, "using" it means installing it because another config
tool you want lists it as a dependency. For developers, you wrap a storage in
`NormalizedReadOnlyStorage` (or use the `NormalizedStorageComparerTrait` to build
a comparer over two normalized storages) so that reads come back normalized and
diffs show only real differences. You can also register your own
`ConfigNormalizer` plugin to reconcile another volatile property for your entity
type. The exact classes, the context options (`compare` vs `provide` mode), and
the plugin API are documented in the [`agent/`](../agent/start.md) references.
