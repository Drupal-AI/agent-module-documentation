Matomo Analytics adds the Matomo (formerly Piwik) JavaScript tracking snippet to your Drupal pages, with fine-grained control over which pages, roles, and users are tracked and what extra data is sent.

---

You enter your Matomo site ID and server URL on the settings form and the module injects the correct tracking code into every page via `hook_page_attachments`. Extensive visibility rules decide where the snippet appears: by request path (allow/deny lists), by user role, and by user account, plus a permission that lets individual users opt in or out of being tracked. Beyond page views it can track outbound links, mail-to links, downloads by file extension, Colorbox events, site search, and set a hashed Matomo user ID for logged-in users. Privacy features include DoNotTrack support and cookie-less tracking. Advanced options let you add custom variables, arbitrary JavaScript snippets before/after the tracker, page-title hierarchy, and cache the `matomo.js` file locally (refreshed on cron). It integrates with core tokens, exposes a Views display extender so a view render can push a Matomo event, and ships a CSP event subscriber so its inline snippet works under a Content-Security-Policy. A bundled **Matomo Tag Manager** submodule manages MTM container snippets instead. Settings are configuration (`matomo.settings`), so tracking setup is exportable and deployable.

---

- Add Matomo page-view tracking to an entire Drupal site.
- Point tracking at a self-hosted Matomo or Matomo Cloud instance by URL and site ID.
- Exclude admin, node-edit, and batch paths from tracking.
- Track only specific sections using request-path allow lists.
- Skip tracking for administrator or editor roles.
- Let users opt in or out of tracking via their account (permission-gated).
- Honor Do Not Track browser signals.
- Enable cookie-less tracking for stricter privacy compliance.
- Track outbound link clicks automatically.
- Track file downloads by extension (pdf, zip, docx, …).
- Track mailto: link clicks.
- Track site-search queries and results.
- Track Colorbox (lightbox) interactions.
- Send a hashed user ID for authenticated users to unify sessions.
- Add custom dimensions/variables to every tracked hit.
- Inject custom JavaScript before or after the tracker for advanced setups.
- Cache matomo.js locally and refresh it on cron to avoid an external request.
- Use page-title hierarchy so Matomo groups pages by structure.
- Deploy identical tracking config across dev/stage/prod as exported config.
- Push a Matomo event from a View via the Views display extender.
- Keep the inline snippet working under a Content-Security-Policy.
- Migrate an old Piwik/Google Analytics configuration via the bundled migrate plugins.
- Manage Matomo Tag Manager containers with the tagmanager submodule.
- Restrict who can administer Matomo settings with a dedicated permission.
- Use tokens to build dynamic tracking values.
