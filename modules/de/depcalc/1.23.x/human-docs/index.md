# Dependency Calculation (Depcalc) — manual setup guide

**Dependency Calculation** (`depcalc`) is a developer API module. Given any
content or configuration entity, it works out the complete, recursive set of
*everything that entity depends on* — every referenced entity, embedded media and
image, Layout Builder component, menu link, path alias, taxonomy parent,
workflow, translation, and the modules that provide them — and caches the result
so it doesn't have to be recomputed. It is the dependency backbone behind
content‑staging and packaging tools such as Acquia Content Hub.

You normally don't install Depcalc because you personally want to use it; you
install it because another module depends on it. It has **no user interface, no
permissions, no routes, and no configuration of its own**. Developers drive it in
code: wrap an entity in a `DependentEntityWrapper`, hand it to the
`DependencyCalculator` service together with a `DependencyStack`, and get back the
full keyed list of dependencies plus the modules involved. The whole calculation
is extensible through the `calculate_dependencies` event, so other modules can
teach it how to resolve custom fields or entity types.

Results are stored in a dedicated, tag‑aware cache bin (`cache_depcalc`) that
deliberately survives an ordinary `drush cr`, because recalculating dependencies
is expensive. When you do need to clear it, Depcalc ships a Drush command,
`depcalc:clear-cache` (alias `dep-cc`), and the optional submodule **Depcalc UI**
adds a "Clear depcalc cache" button in the admin interface.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the service names, the calculation
API, the events, and the Drush command — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally enable the Depcalc UI submodule.

## Where it lives in the admin menu

Depcalc itself adds nothing to the admin menu. If you enable the **Depcalc UI**
submodule, it provides a "Clear depcalc cache" button in the admin interface.
Otherwise the only way to interact with the module directly is the Drush command.

## How to use it

For most sites there's nothing to do beyond enabling it — the tool that requires
Depcalc uses it automatically. The one operation you may run by hand is clearing
its cache, because the depcalc bin intentionally survives a normal cache rebuild:

```bash
drush depcalc:clear-cache   # or the alias: drush dep-cc
```

Developers integrating Depcalc into an export, migration, or deploy pipeline call
the `entity.dependency.calculator` service directly and can extend it with their
own `calculate_dependencies` event subscribers — see the
[`agent/`](../agent/start.md) docs for the exact API.
