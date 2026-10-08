<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple XML sitemap exclude pattern (simple_sitemap_exclude) — agent index

Adds **regex path-pattern exclusions** to Simple XML Sitemap. Requires `simple_sitemap ^4.2`.
Version **1.0.0**, core `^10.2 || ^11.0`. Package SEO. License GPL-2.0-or-later.

## What it is
A single config form of regular-expression patterns (one per line). During sitemap generation,
any link whose **path** matches a pattern is removed. No new permission, no entity, no plugin —
just one settings form and one alter hook.

## Mechanism (verified from source)
- **Form:** `src/Form/SettingsForm.php` — `SettingsForm extends
  \Drupal\simple_sitemap\Form\SimpleSitemapFormBase`. One `patterns` textarea; submit splits on
  newlines, trims, drops empties, saves the array to config. Also renders Simple Sitemap's
  `regenerateNowForm()` ("regenerate now") control.
- **Route:** `simple_sitemap_exclude.settings` → `/admin/config/search/simplesitemap/exclude`,
  guarded by `_permission: 'administer sitemap settings'` (a Simple Sitemap permission — this
  module defines none of its own). Exposed as a local task "Exclusions" under parent
  `simple_sitemap.inclusion`.
- **Config:** `simple_sitemap_exclude.settings:patterns` — a sequence of strings
  (`config/schema/…schema.yml`). Ships empty (`patterns: {  }`).
- **Enforcement:** `simple_sitemap_exclude.module` implements
  `hook_simple_sitemap_links_alter(array &$links, SimpleSitemapInterface $sitemap)`. For each
  pattern it iterates `$links`, computes `$path = str_replace($host, '', $link['url'])` (host =
  `\Drupal::request()->getSchemeAndHttpHost()`), and if
  `preg_match('/' . $pattern . '/', $path)` matches, `unset()`s that link. So each stored line is
  a raw regex **body**, wrapped in `/ /` delimiters, matched against the path portion of the URL.
- **Help:** `hook_help()` renders `README.md` on the `help.page.simple_sitemap` route.

## Behavior notes for agents
- Patterns are **unanchored substring matches** unless the admin anchors them. `^\/node\/.*`
  removes all node paths; `^\/home$` removes only `/home`. Regex special chars must be escaped by
  the author (the examples escape `/` as `\/`, though that is not required inside `/ /` since the
  path has no literal delimiter conflict — the module does not add the delimiter twice).
- Match target is the URL with scheme+host stripped, i.e. a leading-slash path.
- Exclusion runs at link-collection time across sitemap variants; rebuild the sitemap (cron, drush,
  or the form's "regenerate now") for changes to take effect.
- There is no per-bundle or per-entity UI here; use Simple Sitemap's own settings for that. This
  module is the catch-all for "not any URL matching this path shape".

## Files
- `usage.md` — orientation (short / dense / use-cases).
- `agent/config/settings.md` — the settings form, config object, and pattern semantics in detail.

## Gotcha
An exclusion pattern is broader than it looks — a greedy or unanchored pattern can silently drop a
whole content section. Verify the generated sitemap after editing patterns.
