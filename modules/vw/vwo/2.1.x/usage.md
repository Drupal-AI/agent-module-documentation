VWO (Wingify) injects the VWO / Wingify "Smart Code" JavaScript snippet into your site's pages so you can run A/B, split-URL and multivariate experiments, with a settings UI for the account ID, page/role/user visibility rules, and async vs sync loading.

---

The module is a thin front-end integration around a single config object, `vwo.settings`. Its
`hook_page_attachments()` reads the `id` (VWO account ID) and, when set, builds the Smart Code with
`VwoSmartCode` (choosing VWO vs Wingify hosts based on the fetched `is_wingify_account` flag) and
attaches it to `html_head`, either asynchronously (with a `preconnect` link and a settings timeout)
or synchronously (a `<script src>` to the account's `lib/<id>.js`). Which pages get the code is
governed by the `filter` config: a master `filter.enabled` toggle, per-content-type inclusion
(`filter.nodetypes`), per-role inclusion (`filter.roles`), a path list with mode
`filter.page.type` (`listinclude` / `listexclude` / `usephp`) and `filter.page.list`, and a
per-user opt-in/opt-out control (`filter.userconfig`: `nocontrol` / `optin` / `optout`) that adds a
checkbox to the user edit form (stored in `user.data`). Loading behaviour lives under `loading`
(`type`, `timeout.settings`, `timeout.library`, `usejquery`). Configuration is exposed through three
routed forms under `/admin/config/system/vwo` — **Settings** (`vwo.settings`), **Visibility**
(`vwo.settings.visibility`), and **Extract Account ID** (`vwo.settings.vwoid`, which regexes an
Account ID out of a pasted Smart Code) — all gated by the `administer vwo` permission. Two services
back it: `vwo.account_info` (fetches/stores the Wingify flag and collection URL from the VWO API) and
`vwo.help` (help block HTML). It defines no plugins and no Drush commands. Note: you need an active
VWO account/ID for the snippet to do anything.

---

- Add the VWO Smart Code to every page to start running A/B tests site-wide.
- Restrict the VWO snippet to specific content types (e.g. only landing pages).
- Load the VWO code only for certain user roles (e.g. exclude staff/editors from experiments).
- Include or exclude the snippet on a specific list of paths.
- Let authenticated users opt in or out of A/B testing via a checkbox on their profile.
- Paste a full Smart Code snippet and auto-extract the Account ID with the Extract Account ID form.
- Switch between asynchronous and synchronous loading of the VWO library.
- Tune the async settings timeout to control the page-hide/anti-flicker behaviour.
- Run split-URL or multivariate tests by enabling VWO on the relevant pages only.
- Keep experiments off admin/backend paths by excluding those paths.
- Target only logged-in members of a "beta testers" role for experiments.
- Deploy the VWO account ID and visibility rules as exported configuration across environments.
- Preconnect to the VWO/Wingify edge host to reduce experiment load latency (async mode).
- Temporarily disable all VWO code site-wide with the master visibility toggle.
- Use per-user opt-out to respect visitor preferences on running experiments.
- Support both classic VWO and newer Wingify accounts automatically (host is chosen from the account flag).
- Add heatmap/session-recording capability by loading VWO where you need it.
- Limit experiments to a marketing microsite section via path inclusion.
- Provide a friendly "Get started with VWO" prompt to admins configuring the module.
- Cache-correctly vary the snippet by user, role, or path depending on the active filters.
- Roll experiments out gradually by widening the included content types or roles over time.
