<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update Manager Advanced expands Drupal's core "Available updates" notification email to include the full per-project update detail normally shown at `/admin/reports/updates/update` — installed vs recommended versions and release-note links — and adds a "Security Updates" admin block.

---

The module hooks core's update-status notification email via `hook_mail_alter()`: when the
message id is `update_status_notify` and its own setting `notification.extend_email_report` is
on (it ships **on** by default), it appends a rendered list of available updates to the email
body. The list is built by `UpdateDetailsMarkup::createFromProjectData()` from core's
`update_get_available()` + `update_calculate_project_data()`, grouped into Enabled, Disabled,
and "Manual updates required" (core) sections, with each project labelled `(Security update)`,
`(Unsupported)`, etc., and linked to its release notes. The markup is produced through the
render pipeline and translation, and the class hard-disables the untrusted `Markup::create()`
entry point (returns "Not permitted."), so only project data from the update system is
rendered. A checkbox to toggle the feature is added to the core Update settings form
(`update.settings`, path `/admin/reports/updates/settings`) via
`hook_form_update_settings_alter()`. Separately the module provides a **Security Updates**
block (plugin `advupdate_security_updates`) that lists only projects whose status is
`NOT_SECURE`, with installed/recommended versions and a link to the available-updates page;
the block is only visible to users with **`administer site configuration`** and renders
nothing when there are no pending security updates. Requires core `update` and `block`;
core `^11.3`.

---

- Get the full list of available module/theme updates directly in the update notification email.
- Include installed-vs-recommended versions for each project in the update email.
- Add release-note links for each available update to the notification email.
- Flag security updates and unsupported releases inline in the email report.
- Group email update info into Enabled, Disabled, and manual (core) update sections.
- Disable the expanded email without uninstalling, via the Update settings checkbox.
- Display a "Security Updates" block on an admin dashboard listing insecure projects.
- Show admins only the projects with pending security updates (status NOT_SECURE).
- Link the security block to the core available-updates report page.
- Hide the security block automatically when no security updates are pending.
- Replace the need to open `/admin/reports/updates/update` to see update detail.
- Combine with Swift Mailer / a mail theme to receive HTML-formatted update reports.
- Keep site maintainers informed of security releases via routine cron update emails.
- Surface core "manual update required" notices in the email report.
- Restrict the security-updates block to site-configuration administrators.
- Track which contrib modules are behind on their recommended release from your inbox.
