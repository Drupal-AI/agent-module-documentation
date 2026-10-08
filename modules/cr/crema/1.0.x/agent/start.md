<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Class Replacement Manager (crema) — agent index

**Proof-of-concept developer module: "replace" existing PHP classes by declaring them in a module's `info.yml` (`class_replacements:` key), via a prepended custom Composer class loader.**

- **Version:** 1.0.x (dev checkout — `crema.info.yml` has no `version:` line; reflects the 1.0.x development branch). **Core:** `^9 || ^10 || ^11`.
- **Dependencies:** none (empty `require`, no `dependencies:`). No routes, permissions, services.yml, config, hooks, or UI.
- **How it is wired:** `Drupal\crema\CremaServiceProvider` is auto-discovered by DrupalKernel (module-root `<Module>ServiceProvider` convention). Its `register()` runs at container-build time, scans every module's parsed info for `class_replacements`, and — only if any exist — builds and prepends a `CremaClassLoader`.

## What it provides
- **`CremaServiceProvider`** (`src/CremaServiceProvider.php`) — collects replacement maps, clones the kernel's Composer `ClassLoader` internals via reflection, registers the Crema loader prepended.
- **`CremaClassLoader`** (`src/CremaClassLoader.php`, `final`, `@internal`, extends `Composer\Autoload\ClassLoader`) — `loadClass()` intercepts replaced FQCNs and the synthesised `Drupal\_original_\…` namespace; const `ORIGINAL_SUBNAMESPACE = '_original_'`. Module-level include helpers `_crema_include_replacement_file()` / `_crema_include_original_file()` load rewritten source through a `tmpfile()` stream.
- **`ClassCamouflage`** (`src/ClassCamouflage.php`, `final`, `@internal`) — token-level source rewriter: `getNew()` maps replacement `Crema\…`→`Drupal\…`; `getCamouflaged()` maps original→`Drupal\_original_\…`, forces `abstract`, adds `use` statements, FQCN-qualifies self references.
- **`ClassCamouflageTokenParser`** + **`TokenParserShim`** (`src/Utility/`) — static PHP-token helpers; the shim normalises tokenizer differences on PHP < 8.1.

## No security-relevant surface
No web routes, controllers, forms, permissions, external calls, DB queries, or request-derived input. Behaviour is entirely driven by developer-authored `info.yml` declarations resolved at container build.

## Solution docs
- [agent/api/class-replacements.md](api/class-replacements.md) — the `class_replacements` info.yml contract, the loader/camouflage pipeline, replacement-file authoring rules, and limitations.
