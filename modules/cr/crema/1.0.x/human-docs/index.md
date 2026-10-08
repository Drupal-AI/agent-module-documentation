# Class Replacement Manager — manual setup guide

**Class Replacement Manager** (`crema`) is an experimental, proof-of-concept
developer tool that lets a module "replace" an existing PHP class with its own
implementation — declared simply in the replacing module's `info.yml` file, without
patching the original or subclassing it under a new name. As the project itself
cheerfully admits, the idea is deliberately unconventional; this is a primitive for
exploring class overriding, not a typical production feature.

Under the hood, Crema inserts a custom class loader (`CremaClassLoader`) ahead of
Composer's autoloader, registered through a service provider. When the original
class is requested, a "camouflaged" replacement is loaded in its place: a helper
relocates your replacement so it can extend or stand in for the original under the
original's fully-qualified class name. There is no UI, no route, no permission, and
no service configuration — behavior is driven entirely by `info.yml` declarations
in the consuming module.

Because it manipulates the global autoloader, treat Crema as a low-level tool to be
used with care. It comes with real limitations: you cannot replace the same class
more than once, you cannot set debugger breakpoints in either the replacement or the
replaced file, it can only replace most (not all) `Drupal\*` classes — not kernels
or database-driver classes — and each file involved must currently be smaller than
2 MB. It supports Drupal 9, 10, and 11 and has no dependencies of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form,
route, or permission. Everything is driven from the `info.yml` of the module doing
the replacing, described in "How to use it" below.

## How to use it

Crema is configured entirely from the *consuming* module — the one that wants to
replace a class:

1. Add a `class_replacements` key to that module's `.info.yml`. Each entry maps the
   fully-qualified name of the class to replace to the path (relative to the
   module root) of the replacement file:

   ```yaml
   name: Migration Manager Replacement
   type: module
   class_replacements:
     Drupal\migrate\Plugin\MigrationPluginManager: src/migrate/MigrationPluginManager.php
   ```

2. Make that module depend on `crema` (or have a good reason not to).
3. Create the replacement file at the declared path. Its namespace must be the
   original class's namespace with the leading `Drupal` replaced by `Crema`, and the
   class name must match the original. To extend the original — which is usually what
   you want — add an aliased `use` declaration of the original class:

   ```php
   <?php
   namespace Crema\migrate\Plugin;

   use Drupal\migrate\Plugin\MigrationPluginManager as Original;

   class MigrationPluginManager extends Original {
     // Your overrides here.
   }
   ```

4. Clear caches so the service provider and class loader pick up the change.

To roll an override back, remove the `class_replacements` declaration and clear
caches again.
