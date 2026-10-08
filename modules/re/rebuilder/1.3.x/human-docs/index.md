# Rebuilder — manual setup guide

**Rebuilder** (`rebuilder`) lets you rebuild a specific cached thing in Drupal
*without* running a full cache clear. When you change one piece of code — a service,
a theme registry, a router — a complete `drush cr` feels excessive: most of what it
throws away is unrelated to your change, and on a large, busy site that blanket
rebuild is a real, site‑wide performance hit for everyone. Rebuilder gives you a
scalpel instead of a sledgehammer.

It's also a memory aid. Drupal's cache API supports precise invalidation, but the
exact service or command to rebuild any given thing is easy to forget and named
inconsistently. Rebuilder collects the common ones behind a single, consistent
interface. It's built around a **plugin manager** with a base plugin and several
ready‑made "rebuilders," so developers can add their own for project‑specific caches
by implementing the plugin API.

You invoke rebuilders two ways: from **Drush** on the command line, or through an
optional **UI submodule** that adds an admin form where you can run any available
rebuilder with a click. (The project is named "Rebuilder" rather than "Rebuild" to
avoid colliding with the existing Drush Rebuild project and the `cache:rebuild`
Drush alias.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional UI submodule).

There is **no central settings page** to configure — Rebuilder is a tool you run,
not a feature you tune. See "How to use it" below.

## Where it lives in the admin menu

If you enable the UI submodule, its admin form is at **Configuration → Development
→ Performance → Rebuilder**
(`/admin/config/development/performance/rebuilder`).

## How to use it

**From Drush** (available once the base module is enabled):

```bash
# List every available rebuilder plugin
drush rebuilder:list

# Run a specific rebuilder (rebuilder:run; `rebuilder` is an alias)
drush rebuilder <plugin_id>
```

**From the UI** (requires the UI submodule): go to **Configuration → Development →
Performance → Rebuilder** and run the rebuilder you need from the form. Access is
gated by the module's permission, so grant it only to trusted roles.

**Writing your own:** because Rebuilder is a plugin manager, you can add a
rebuilder for a project‑specific cache by implementing the plugin API — see the
Drupal Plugin API documentation.
