Message Banner displays a single site-wide, optionally dismissible message banner to visitors, configured from one admin settings form. It injects the banner via `hook_page_attachments` and renders it client-side with JavaScript, remembering dismissal for a configurable number of minutes.

---

The whole module is one config form (`/admin/config/user-interface/message-banner`, route `message_banner.settings`) writing to `message_banner.settings`, plus a `hook_page_attachments` implementation. When `banner_enabled` is on, and the current user has the `view message banner` permission (granted to anonymous and authenticated on install), the module renders the `message_banner` theme hook — the `banner_text` rich-text value run through `check_markup` with its stored text format — into a string and passes it, plus behavior flags, to the browser as `drupalSettings.messageBanner`; `js/message_banner.js` then prepends it to the page (to `body` by default, or a CSS selector via `banner_override_selector`). Options include a color class (`banner_color`, extensible through `hook_message_banner_colors_alter`), a close/dismiss button that can be disabled (`banner_disable_close`), a re-show interval after dismissal (`banner_show_again_minutes`), and whether the banner also appears on admin routes (`banner_enabled_on_admin_routes`, off by default). A save timestamp is stored in state (`banner_saved`) so a re-saved banner reappears even for users who previously dismissed it. Cache contexts include `user.roles` and the config's cache tags. The banner text is authored by an admin holding `manage message banner` in whatever text format they choose, so its raw markup is trusted admin content.

---

- Show a site-wide announcement (maintenance window, holiday hours) to all visitors.
- Display a cookie/GDPR notice bar at the top of every page.
- Post a temporary promotional or event banner and remove it by unchecking "Enable banner".
- Add a dismissible notice users can close, with a "show again after N minutes" cadence.
- Show a non-dismissible banner (disable the close button) for critical notices.
- Restrict the banner to front-end pages only, or also enable it on admin routes.
- Color-code the banner (red/amber/green/black/gray/white) to signal severity.
- Add brand or custom colors to the banner picker via `hook_message_banner_colors_alter`.
- Prepend the banner to a custom DOM element (e.g. `.region-highlighted`) instead of `body`.
- Author rich banner text (links, emphasis) using a chosen text format.
- Hide the banner from certain roles by removing their `view message banner` permission.
- Re-surface an updated banner to everyone (even prior dismissers) by re-saving the form.
- Delegate banner management to an editor role via the `manage message banner` permission.
- Provide a lightweight alternative to full "announcements"/message modules for one notice.
- Warn logged-in users about scheduled downtime without a custom block.
- Localize the banner text and settings (config translation is supported).
- Signal a staging/pre-production environment with a persistent colored bar.
- Show a call-to-action bar (newsletter, survey link) across the whole site.
- Communicate a service degradation notice site-wide during an incident.
- Keep the banner off admin pages so editors are not distracted while working.
