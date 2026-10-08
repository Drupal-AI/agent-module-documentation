# CacheFlush — manual setup guide

**CacheFlush** (`cacheflush`) lets you build reusable **presets** that clear
exactly the caches you choose, instead of always flushing everything. On a big
site a full cache rebuild is slow and disruptive; often you only changed a
template and just need the Twig and render caches cleared, or you added a route
and only need the router rebuilt. CacheFlush turns those targeted clears into
named, one-click actions you can reuse and share across your team.

Each preset is a small configuration entity that remembers which cache bins and
cache-clearing operations to run. The base module contributes a catalogue of
clearable things — static caches, assets (CSS/JS), the service container, Twig
storage, plugin definitions, module/theme data, and the router — plus every
registered cache bin on your site, and other modules can add their own. You tick
the ones you want in a preset, then trigger that preset from the admin menu, a
bookmark, cron, or Drush.

Out of the box the base module gives you two ready-made links — a "clear all"
action and a "clear this preset" action — both protected by a dedicated
permission so you can decide who is allowed to flush caches. The preset-building
**UI**, the storage entity, and extras like cron scheduling and Drush support are
split across several submodules, described in [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need (the UI and entity submodules
   matter most).
2. [Configuration](configuration/index.md) — building presets, the ready-made
   clear links, and the permission that guards them.

## Where it lives in the admin menu

The base module's configure link is **CacheFlush** at `/admin/cacheflush`, and it
ships two clear actions: `/admin/cacheflush/clear/all` (flush everything) and
`/admin/cacheflush/clear/{preset}` (run a specific preset). Both require the
**Cacheflush clear cache** permission. When you enable the UI submodule, the
preset add/edit forms appear under **Structure** at
`/admin/structure/cacheflush`.

## How to use it

The everyday path is: enable the module together with its UI submodule, create a
preset that selects just the caches you care about (for example a "front-end dev"
preset that clears Twig, assets and render cache only), then trigger that preset
whenever you need it. See [Configuration](configuration/index.md) for the details.
