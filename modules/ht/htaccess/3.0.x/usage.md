<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Htaccess provides an admin form that combines Drupal's scaffold `.htaccess` with your own extra Apache directives and writes the result to the docroot, optionally rewriting it on every cron run.

---

The 3.x branch is a rewrite focused on one job: managing the site's root `.htaccess` from Drupal's UI instead of editing it over FTP/SSH. At `/admin/config/system/htaccess` you get a path to the default `.htaccess` content (by default core's scaffold file, `core/assets/scaffold/files/htaccess`), a read-only preview of that content, and an editable textarea of "extra configurations" that are appended to it. Saving concatenates the two and writes `DRUPAL_ROOT/.htaccess`; a checkbox makes `hook_cron()` keep the file in sync with your configuration on every run. The whole thing is one form plus a cron hook, gated by a single `restrict access: true` permission, `administer htaccess`. A status-report requirement flags when clean URLs are off or the docroot is not writable. A companion submodule, Robots.txt Utils, deletes the physical `robots.txt` (on save and on cron) so search engines read the dynamic version produced by the Robotstxt module.

Because the module writes the real `.htaccess`, treat the "extra configurations" as production server config: test directives before enabling automatic replacement, keep a copy of a known-good file, and grant `administer htaccess` only to trusted operators. On a read-only production docroot the write step reports an error instead of changing anything.

---

- Manage a per-site `.htaccess` from the UI in a multisite install.
- Add custom Apache directives without shell or FTP access to the server.
- Append extra security-header or `FilesMatch` rules to the generated file.
- Add redirect or rewrite rules for a single site through the admin form.
- Keep the docroot `.htaccess` in sync with configuration automatically via cron.
- Start from Drupal's own scaffold `.htaccess` as the base content.
- Point the base at a different template file by changing the path field.
- Preview the current default `.htaccess` content before appending to it.
- Deploy `.htaccess` changes through configuration workflow rather than code deploys.
- Restore the scaffold defaults by resetting the path field to the core scaffold file.
- Check via the status report whether clean URLs are enabled and the docroot is writable.
- Audit which extra directives a site has accumulated in one place.
- Enable one-click updates of `.htaccess` from within Drupal for operators.
- Combine performance directives (caching, compression) with the core defaults.
- Ensure a stale physical `robots.txt` does not shadow the dynamic Robotstxt output (via the submodule).
- Centralize `.htaccess` management for teams that prefer the admin UI to filesystem edits.
- Turn automatic cron replacement on for environments where config is the source of truth.
- Turn automatic replacement off to make `.htaccess` writes a deliberate manual action.
