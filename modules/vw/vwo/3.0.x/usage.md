VWO (Wingify) injects the VWO / Wingify "Smart Code" JavaScript snippet into your site's pages so you can run A/B, split-URL and multivariate experiments, with a settings UI for the account ID, page/role/user visibility rules, and async vs sync loading.

---

The module is a thin front-end integration built around a single config object, `vwo.settings`. Its `hook_page_attachments()` (in `vwo.module`) reads the account `id` and, when set and permitted by the visibility filter, builds the Smart Code with the `VwoSmartCode` helper class and attaches it to `html_head`. In this 3.0 major it emits the V3.0 async snippet (a self-contained `window._vwo_code`/`window._wingify_code` bootstrap with a settings-tolerance anti-flicker timeout) plus a `preconnect` link, or, in sync mode, a `<script src>` pointing at the account's `/tag/<id>.js`. A new `AccountInfo` service (`vwo.account_info`) calls the VWO account-info endpoint once to learn whether the ID is a newer "Wingify" account, caching an `is_wingify_account` flag and `coll_url` in config; that flag chooses between the `edge.wingify.net` and `dev.visualwebsiteoptimizer.com` hosts and the `wingifyCode`/`vwoCode` script element id. Which pages get the code is governed by the `filter` config: a master `filter.enabled` toggle, per-content-type inclusion (`filter.nodetypes`), per-role inclusion (`filter.roles`), a path list with mode `filter.page.type` (`listinclude` / `listexclude` / `usephp`) and `filter.page.list`, and a per-user opt-in/opt-out control (`filter.userconfig`) that adds a checkbox to the user edit form (stored in `user.data`). Loading behaviour lives under `loading` (`type`, `timeout.settings`). Configuration is exposed through three routed forms under `/admin/config/system/vwo` — Settings (`vwo.settings`), Visibility (`vwo.settings.visibility`), and Extract Account ID (`vwo.settings.vwoid`, which regexes an Account ID out of a pasted Smart Code). It defines no plugins and no Drush commands, and you need an active VWO/Wingify account for the snippet to do anything.

---

- Add the VWO/Wingify Smart Code to every page to start running A/B tests site-wide.
- Restrict the snippet to specific content types (e.g. only landing pages) via content-type filtering.
- Load the code only for certain user roles (e.g. exclude staff/editors from experiments).
- Include or exclude the snippet on a specific list of Drupal paths (with `*` wildcards and `<front>`).
- Let authenticated users opt in or out of A/B testing via a checkbox on their profile edit form.
- Paste a full Smart Code snippet and auto-extract the Account ID with the Extract Account ID form.
- Switch between asynchronous (default, V3.0 snippet) and synchronous loading of the library.
- Tune the async settings-tolerance timeout to control the page-hide / anti-flicker behaviour.
- Run split-URL or multivariate tests by enabling VWO only on the relevant pages.
- Keep experiments off admin/backend paths by excluding those paths from inclusion.
- Target only logged-in members of a "beta testers" role for experiments.
- Deploy the account ID and visibility rules as exported configuration across environments.
- Preconnect to the VWO/Wingify edge host to reduce experiment load latency in async mode.
- Temporarily disable all VWO processing site-wide with the master visibility toggle.
- Use per-user opt-out to respect visitor preferences on running experiments.
- Support both classic VWO and newer Wingify accounts automatically (host is chosen from the account flag).
- Add heatmap / session-recording capability by loading the snippet where you need it.
- Limit experiments to a marketing microsite section via path inclusion.
- Provide a friendly "Get started for free" prompt to admins on the settings screen.
- Cache-correctly vary the snippet by user, role, or path depending on the active filters.
- Roll experiments out gradually by widening the included content types or roles over time.
- Manually inject the snippet from a custom module (leaving the visibility filter disabled) for full control.
