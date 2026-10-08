# Configuration

CacheFlush is configured by building **presets** — each one a saved list of the
caches it should clear. The base module supplies the clear engine and two
ready-made links; the form for building presets comes from the **`cacheflush_ui`**
submodule, so enable that first (see [Installation](../installation/index.md)).

## Who is allowed to clear caches

The base module defines one permission: **Cacheflush clear cache**. A user needs
it to use any of the clear links below. Grant it under **People → Permissions**
only to trusted roles — clearing caches on a busy site has a performance cost.
The UI submodule adds finer-grained permissions on top of this.

## The ready-made clear links

Even before you build a preset, two actions are available:

- **Clear everything** — `/admin/cacheflush/clear/all`. This runs Drupal's full
  cache flush (the equivalent of "Flush all caches"), shows a confirmation
  message, and logs who did it. Handy as a quick full-flush bookmark.
- **Clear a specific preset** — `/admin/cacheflush/clear/{preset}`. Runs just the
  operations stored in that preset. You can bookmark it or link to it from a
  script.

## Build a preset

With `cacheflush_ui` enabled:

1. Go to **Structure → CacheFlush** (`/admin/structure/cacheflush`) and choose to
   add a preset (`/admin/structure/cacheflush/add`).
2. Give it a **title** (for example "Front-end dev" or "Render only").
3. Tick the caches it should clear. The catalogue is presented as checkboxes
   grouped into vertical tabs, and it includes:
   - **Every registered cache bin** on your site (core and contrib), so you can
     clear one module's bin without touching the rest.
   - The base module's built-in operations: **static** (reset static caches),
     **asset** (CSS/JS aggregates), **kernel** (rebuild the service container),
     **twig** (wipe the compiled Twig templates), **plugin** (plugin definition
     caches), **module** (rebuild module/theme data), and **router** (rebuild the
     route table).
   - Anything other modules contribute to the catalogue, plus, with
     `cacheflush_advanced`, specific cache IDs and cache tags.
4. **Save.** The preset is stored as a small entity, and it must be **enabled**
   (published) to run — a disabled preset returns an access-denied when you try to
   clear it.

## Run a preset

Trigger it however suits you:

- Visit `/admin/cacheflush/clear/{preset}` (or bookmark it).
- With `cacheflush_ui`, optionally surface frequently used presets as items in the
  **Cacheflush** admin menu.
- With `cacheflush_cron`, run a preset automatically on a schedule.
- With `cacheflush_drush`, run it from the command line (note the compatibility
  caveat mentioned in [Installation](../installation/index.md)).

## Typical presets

- **Front-end dev** — Twig + asset + render cache only, for quick template
  iteration.
- **After adding routes** — router (and plugin) only.
- **Editor "clear page cache"** — a single bin, exposed as a one-click admin-menu
  link for content teams.

Building focused presets like these means you clear only what changed, which is
much faster than a full rebuild on a large site.
