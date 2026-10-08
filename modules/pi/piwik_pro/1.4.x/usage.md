Piwik PRO injects the Piwik PRO tag-manager container (tracking snippet) into your site so visitor data is collected by the Piwik PRO analytics platform, with page-, role-, and content-type-based rules controlling where the snippet loads. (This is Piwik PRO, not the original Piwik/Matomo.)

---

The module builds the Piwik PRO container `<script>` from settings and adds it to page output.
`PiwikProSnippet` (service `piwik_pro.snippet`) assembles the snippet from your **Account ID**
(`site_id`), **tracking domain** (`piwik_domain`), and **data layer** name, and only emits it
when the current request passes all three visibility checks — request path
(`request_path_mode` + a path list, defaulting to "every page except" admin/batch/node-add/user
paths), user role (`user_role_mode` + roles), and content type (`content_type_mode` +
content types), each invertible. Cookie behavior is configurable via `use_secure_cookies` and
`same_site_strict` (SameSite=Strict), and a `disable_tracking` master switch is available.
Settings live at `/admin/config/services/piwik-pro` (route `piwik_pro.admin_settings_form`,
permission `administer piwik pro`; the permission is `restrict access: TRUE`). For sites running
a Content-Security-Policy, enabling `csp_nonce_enabled` (with the CSP module installed) makes the
snippet carry a nonce, and a `PiwikProCspAlterSubscriber` event subscriber adjusts the policy;
CSP integration is optional (services use it via `@?csp.nonce_builder` / `@?csp.policy_helper`).
The Account ID and tracking domain are public client-side identifiers embedded in page HTML —
not secrets. An optional **Piwik Pro Dashboard** submodule adds an in-admin analytics dashboard.

---

- Add Piwik PRO tracking to an entire Drupal site with one configuration form.
- Exclude admin, node-add, and user pages from tracking by default.
- Track only a specific set of pages by inverting the path-visibility mode.
- Stop tracking for administrator or editor roles.
- Track only anonymous visitors by selecting roles and inverting the role mode.
- Limit tracking to specific content types (e.g. only articles).
- Exclude certain content types (e.g. internal landing pages) from analytics.
- Set a custom data-layer name to integrate with the Piwik PRO tag manager.
- Enable secure cookies for the tracker on HTTPS sites.
- Enforce SameSite=Strict cookies for stricter privacy/CSRF posture.
- Temporarily disable all tracking with the master switch during maintenance.
- Serve the snippet with a CSP nonce so it passes a Content-Security-Policy.
- Point the snippet at your organization's Piwik PRO container domain.
- Keep GDPR-oriented analytics with a privacy-first platform.
- Roll out tracking to a staging environment without touching templates.
- Combine role and content-type rules for fine-grained tracking scope.
- Load the snippet from a library variant when needed.
- Give a limited admin role rights to manage tracking via a restricted permission.
- Add an in-admin analytics dashboard via the Piwik Pro Dashboard submodule.
- Migrate from Matomo/Piwik by switching to the dedicated Piwik PRO module.
- Manage all tracking configuration in exportable Drupal config.
