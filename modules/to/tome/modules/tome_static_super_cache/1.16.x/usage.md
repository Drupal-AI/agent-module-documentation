<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome Static Super Cache changes core and Tome Static caching so a `drush cr` or a single node save no longer wipes the whole Tome Static cache, dramatically speeding up repeated static builds on large sites.

---

Tome Static keeps rendered pages in its own `cache.tome_static` bin, but two core behaviors defeat it: clearing all caches (UI or `drush cr`) wipes that bin, and list cache tags (e.g. `node_list`) mean any single node save invalidates every View's cache. This sub-module fixes both by decorating services. `SuperStaticCache` (decorates `cache.tome_static`) ignores ordinary full-cache-clears so Tome Static cache survives a normal rebuild — only a genuine full rebuild (the "Fully clear caches" button on `/admin/config/development/performance`, or the `tome:super-cache-rebuild`/`tscr` console command, or `drupal_flush_all_caches()` with the rebuild flag) actually clears it. `TomeStaticSuperCacheTagsInvalidator` (decorates `cache_tags.invalidator`) drops list-tag invalidations that would needlessly wipe caches. It also provides a Views cache plugin, **"Smart tag based"** (id `tome_static_super_cache_smart_tag`), that avoids list cache tags: on entity insert/update it partially re-runs each View using the plugin to check whether that specific entity would appear, and only then clears a View-specific cache tag. Assign this plugin to your Views' caching for maximum benefit. The module has no settings form; you enable it, click "Fully clear caches" when you need a real rebuild, and switch Views to the Smart tag plugin.

---

- Stop `drush cr` and "Clear all caches" from wiping the entire Tome Static cache.
- Keep static builds warm so repeated `drush tome:static` runs only regenerate what changed.
- Prevent a single node save from invalidating every View's cache via `node_list`.
- Speed up static generation on large content sites.
- Assign the "Smart tag based" (`tome_static_super_cache_smart_tag`) cache plugin to a View.
- Clear a View's cache only when an entity that actually appears in it changes.
- Fully rebuild caches deliberately with the "Fully clear caches" button on the Performance page.
- Trigger a genuine full rebuild programmatically via `drupal_flush_all_caches()` with the rebuild flag.
- Reduce unnecessary re-rendering during editorial activity.
- Pair with tome_static_cron so incremental cron builds stay cached between runs.
- Avoid list-cache-tag churn on high-traffic listing pages.
- Improve build times for sites with many Views and frequent content edits.
- Keep image-style and asset derivatives cached across normal cache clears.
- Let editors save content without silently invalidating unrelated static pages.
- Decorate the Tome Static cache bin to survive routine maintenance cache clears.
- Selectively invalidate a custom per-View cache tag instead of broad list tags.
- Get a performance win with zero configuration beyond enabling and choosing the Views plugin.
- Diagnose over-invalidation problems by moving Views onto smart-tag caching.
- Preserve cache across deploys that run a standard cache rebuild (not a full flush).
- Combine longer-lived caching with Tome Static's incremental export model.
