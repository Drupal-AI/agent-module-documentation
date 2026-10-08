<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Injects a browser Speculation Rules script so same-site links are prefetched or prerendered on hover/click for near-instant navigation.

---

Speculative Loading adds native browser Speculation Rules to every page. On `hook_page_attachments` it emits one inline `<script type="speculationrules">` in the head whose JSON tells Chromium-based browsers to prefetch or prerender same-origin links the visitor is likely to click, so the next page is already loading (or fully rendered) before the click. There is no JavaScript library, no server request, and nothing per-visitor — the same rules ship on every response and the browser does all the work.

Two site-wide settings drive it (config object `speculative_loading.settings`, form at `/admin/config/development/performance/speculative-loading`): `mode` chooses `prefetch` (fetch the document only) or `prerender` (fully render the page in the background — faster, default), and `eagerness` chooses how aggressively the browser triggers — `conservative` (about on click), `moderate` (about on hover, default) or `eager` (on the slightest hint). The rule matches every same-site URL (`/*`) and then subtracts a fixed exclude list: `/admin/*`, `/user/login*`, `/user/logout*`, `/user/register*`, any files/modules/themes asset path, and every URL carrying a query string (`?…`). Links marked `rel="nofollow"` are always skipped; in prerender mode links with the CSS class `no-prerender` are skipped too.

The exclude list is not configurable through the UI, but other modules can extend it in code via `hook_speculation_rules_href_exclude_paths_alter($exclude_paths, $mode)` — e.g. to keep a cart or checkout path from being prerendered. The module also defines a `SpeculationRules` plugin type (manager `plugin.manager.speculation_rules`), but the manager builds the rule JSON itself and does not consume plugin output, so the alter hook is the practical extension point. Effects are only visible in browsers that support the Speculation Rules API; others simply ignore the script.
---
- Speed up navigation by prerendering the next page before the visitor clicks.
- Switch to prefetch mode when full prerender is too aggressive for interactive pages.
- Tune how early speculation fires with the eagerness setting (conservative/moderate/eager).
- Turn a whole site "instant" without adding a JS library or per-link markup.
- Prerender same-origin links only — cross-origin URLs are never matched.
- Keep admin pages (`/admin/*`) out of speculation by default.
- Keep login/logout/register paths out of speculation by default.
- Skip asset URLs (files, modules, themes directories) automatically.
- Skip any URL that carries a query string automatically.
- Opt a specific link out of prerender by adding the `no-prerender` CSS class.
- Opt any link out of speculation with `rel="nofollow"`.
- Exclude extra paths (e.g. `/cart/*`, `/checkout/*`) from code with the alter hook.
- Apply different exclusions for prefetch vs prerender via the hook's `$mode` argument.
- Read or change the mode with `drush config:get/set speculative_loading.settings`.
- Set defaults (prerender + moderate) simply by enabling the module.
- Improve perceived load time / Core Web Vitals for anonymous browsing.
- Gate the settings form behind the core "administer site configuration" permission.
- Verify the emitted rules by viewing page source for the `speculationrules` script.
- Confirm behavior in a Chromium browser (Speculation Rules API required).
- Remove all rules cleanly by uninstalling — config is deleted on uninstall.
