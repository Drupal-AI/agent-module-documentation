Speculative Loading adds browser Speculation Rules API support to Drupal, so Chromium browsers prefetch or prerender likely next pages for near-instant navigation.

---

The module implements Drupal core's `hook_page_attachments()` to inject a single inline `<script type="speculationrules">` block into the `<head>` of every page. The JSON it emits tells the browser to speculatively load same-site links (via `href_matches` on the site base path), while excluding admin, login/logout/register, user-reset/confirm, static asset paths (files, modules, themes), query-string URLs, `rel="nofollow"` links, and — in prerender mode — links carrying the `.no-prerender` CSS class. Two site-wide settings control behaviour: `mode` (`prefetch` = lightweight resource fetch, or `prerender` = full background page render) and `eagerness` (`conservative`, `moderate`, or `eager`), both editable at `/admin/config/development/performance/speculative-loading` (permission `administer site configuration`). Rule assembly lives in the `SpeculationRulesManager` plugin manager; per-context path prefixing (site, files, modules, themes) is handled by the `UrlPatternPrefixer` service. Extensibility comes from a `SpeculationRules` plugin type plus `hook_speculation_rules_href_exclude_paths_alter()`, which lets other modules add or remove excluded path patterns per mode. Works automatically once enabled; non-Chromium browsers ignore the markup harmlessly. Only dependency is core `system`.

---

- Speed up perceived navigation on content sites by prerendering the next page while a user hovers a link.
- Enable lightweight prefetch mode on sites with interactive content where full prerender could double-run scripts.
- Improve Core Web Vitals / LCP on article, blog, and documentation sites where readers click sequentially.
- Give near-instant loads for menu, breadcrumb, and pager links without any JavaScript framework.
- Choose conservative eagerness to only speculate on links the user is very likely to click (on click).
- Choose moderate eagerness to trigger speculation on hover (the default).
- Choose eager eagerness to speculate at the slightest pointer suggestion for the fastest feel, at higher bandwidth cost.
- Exclude a specific link from prerendering by adding the `no-prerender` CSS class to its `<a>` tag.
- Keep cart, checkout, or one-time-action links out of speculation via `hook_speculation_rules_href_exclude_paths_alter()`.
- Prevent prerendering of state-changing links (node add/edit/delete, user edit) — already excluded by the default plugin in prerender mode.
- Avoid speculatively loading authenticated flows: login, logout, register, password reset, and confirm paths are excluded out of the box.
- Skip static assets (public files, module and theme directories) from speculation automatically.
- Skip URLs with query parameters from speculation (excluded by a built-in pattern).
- Respect SEO/link hints by not speculating on `rel="nofollow"` links.
- Add a custom `SpeculationRules` plugin to layer site-specific rules or exclusions on top of the defaults.
- Pair with BigPipe for progressive rendering of the speculated pages.
- Deploy on multilingual or subdirectory installs where the base path is honoured by the URL pattern prefixer.
- Roll out site-wide performance gains with a no-code install: enable the module and it works with sane defaults.
- Tune per-environment: prefetch on staging with dynamic content, prerender on a mostly-static production site.
- Reduce bounce on marketing landing pages by making the next click feel instantaneous.
- Export the two-key `speculative_loading.settings` config with your site config for reproducible deploys.
- Uninstall cleanly — `hook_uninstall()` deletes the config object, leaving no residue.
