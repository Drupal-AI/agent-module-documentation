<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automatic Anchors (auto_anchors) — agent index

Client-side JavaScript that generates HTML `id` attributes on chosen page elements (default `h2`–`h6`
inside `body`) so any section can be deep-linked, and can insert an inline `#` permalink into each.
Version **3.0.0-beta1** — **beta**, not covered by the security advisory policy. Core `^10.1 || ^11`.
No Composer dependencies, no submodules, no Drush commands.

## Mechanism (read this first — it changes the advice)
Everything happens in the browser. `auto_anchors_page_attachments()` (in `auto_anchors.module`) attaches
the `auto_anchors/auto_anchors` library and passes settings via `drupalSettings` on every front-end page
(skipped on admin routes when `exclude_admin_pages` is on). `js/auto_anchors.js` runs on the window
`load` event and, using jQuery:
1. Builds a selector by combining each `root_elements` entry with each `anchor_elements` entry
   (both are admin-configured comma-separated CSS selector lists).
2. For every match **without** an existing id, derives an id from the element's `text()`:
   strip apostrophes, replace URL-unsafe chars with `-`, collapse repeats, truncate to 64 chars,
   trim hyphens, lowercase; de-duplicate page collisions with a `-1`, `-2`… suffix
   (`generateUniqueId`/`generateAnchor`). Existing ids are returned as-is and never overwritten.
3. If the current user has `show automatic anchor links`, appends
   `<a class="auto-anchor" href="#id">{link_content}</a>` **inside** each matched element.
4. Smooth-scrolls to `window.location.hash` if that element exists.

Consequences that matter for agents:
- **Ids are not in the server-rendered HTML.** Crawlers, RSS readers, and no-JS clients never see them,
  so this is *not* an SEO feature and a server-side table-of-contents cannot read these ids.
- **Ids are recomputed from live text on every load.** Editing a heading silently changes its id and
  breaks previously shared links; identically-titled sections collide and the dedupe suffix depends on
  document order, so inserting a section can redirect an existing link.

## Configuration
- Route `auto_anchors.settings` → `/admin/config/auto_anchors/settings`, permission
  `administer automatic anchors` (`restrict access: true`). Menu link under *Configuration › Content*.
- Config object `auto_anchors.settings` (schema provided): `root_elements` (string, default `body`),
  `anchor_elements` (string, default `h2, h3, h4, h5, h6`), `link_content` (string, default `#`),
  `exclude_admin_pages` (bool, default `true`). See [config/settings.md](config/settings.md).

## Permissions
- `show automatic anchor links` — per-user visibility of the inline permalink control.
- `administer automatic anchors` (`restrict access: true`) — access the settings form.

## Files
- `auto_anchors.module` — `hook_page_attachments`, `hook_help`.
- `js/auto_anchors.js` — the whole id/permalink engine (jQuery). `css/auto_anchors.css` styles `.auto-anchor`.
- `src/Form/SettingsForm.php` — `ConfigFormBase` settings form.
- `config/install/auto_anchors.settings.yml`, `config/schema/auto_anchors.schema.yml`.
