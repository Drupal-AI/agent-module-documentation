Disable Web Install removes the ability to install modules and themes through the Update Manager's browser UI, while leaving the update-availability notifications intact.

---

Drupal core's Update Manager (the `update` module) can install and update modules and themes directly from the web UI by uploading an archive or supplying a URL — a flow that lets an administrator (or an attacker who has gained an admin session) push arbitrary code onto the server without touching the filesystem or the deployment pipeline. Disable Web Install closes that flow: it uses a dynamic route subscriber to override the three Update Manager install routes (`update.module_install`, `update.report_install`, `update.theme_install`) with a controller that simply redirects back to the module list, update status, or theme list, and it strips the matching "Install new module/theme" menu links and local actions so the entry points disappear from the admin UI. It keeps the useful half of Update Manager — the "updates available" reports and email notifications — so you still learn about security releases; you just apply them through Composer or your filesystem deployment instead of the browser. The module has no configuration, no permissions, and no settings form: enabling it is the entire configuration. It depends only on core `system` and `update`.

---

- Harden a production site so no one can upload a module or theme archive through the browser.
- Enforce a Composer-based deployment workflow by removing the web install shortcut entirely.
- Prevent a compromised admin account from installing arbitrary code via the Update Manager UI.
- Keep "update available" notifications and the update status report working after locking down web install.
- Remove the "Install new module" local action from `/admin/modules`.
- Remove the "Install new theme" local action from `/admin/appearance`.
- Redirect anyone who reaches `/admin/modules/install` back to the module list instead of the install form.
- Redirect `/admin/theme/install` back to the appearance page.
- Redirect the Update Manager report-install route back to the update status page.
- Satisfy a security-review requirement that "the site cannot install code from the web".
- Reduce the attack surface of a shared or agency-hosted Drupal site.
- Complement (not replace) restricting the `administer modules` / `administer themes` permissions.
- Discourage administrators from side-loading contrib outside version control.
- Standardize deployments so every environment gets the same code via Composer.
- Ship a baseline hardening module as part of a site install profile or distribution.
- Pair with read-only filesystem hardening so both the code path and the UI path are closed.
- Avoid accidental installation of an untrusted module archive by a well-meaning admin.
- Keep the update module enabled for its notifications without exposing its install capability.
- Drop the module into a config-management workflow (no config to export; enable it via `core.extension`).
- Apply the same hardening across a multisite by enabling the module per site.
- Document, in an agent knowledge base, exactly which core routes the web-install flow uses.
