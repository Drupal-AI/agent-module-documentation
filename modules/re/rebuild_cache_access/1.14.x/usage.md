Rebuild Cache Access adds a one-click "Rebuild Cache" button to the Drupal admin toolbar (and a Navigation-module block) that any role can be granted, so non-developers can flush all caches without the command line or the performance settings page.

---

By default only users who can reach `/admin/config/development/performance` (typically admin/UID 1) can clear Drupal's caches through the UI, and everyone else needs Drush or `drush cr`. This module defines a single permission, "Rebuild Cache", and exposes a toolbar tab that triggers a full `drupal_flush_all_caches()` rebuild for any role that holds it. The action runs through a CSRF-protected route (`/rebuild-cache-access/rebuild-cache`) and a controller that clears caches and returns the user to where they were with a status message. It also ships a block plugin for Drupal's new Navigation module so the button works in that UI too. A small CSS library styles the toolbar tab with an icon. There is no configuration form — you simply enable the module and grant the permission on the People → Permissions page. It is a lightweight convenience/utility for editorial and support teams who frequently need a cache clear but should not have broad administrative access.

---

- Give content editors a safe "Rebuild Cache" button without full admin rights.
- Let support staff clear caches after a config change from any admin page.
- Grant a specific role cache-clearing power via one permission.
- Flush all Drupal caches from the toolbar instead of the performance page.
- Avoid handing out access to `/admin/config/development/performance`.
- Replace "run `drush cr` for me" requests from non-technical users.
- Clear caches after deploying a template or CSS change so editors see it immediately.
- Add a cache-rebuild control to sites where developers have no shell access.
- Show the rebuild button in the new Navigation module via its block.
- Provide a quick cache reset during content QA and review workflows.
- Let a marketing team refresh cached blocks after a menu change.
- Reduce helpdesk tickets asking an admin to clear the cache.
- Trigger a full cache rebuild after importing configuration.
- Force regeneration of aggregated CSS/JS after a theme tweak.
- Give a client a single, obvious button on a handover site.
- Clear render/page caches when a stale page is reported.
- Keep cache-clearing behind a CSRF-protected route for safety.
- Restrict who can rebuild caches by scoping the permission to trusted roles.
- Add the button only for authenticated staff, not anonymous visitors.
- Use it on multisite installs where each editor manages their own cache.
- Speed up a "did that fix it?" loop during site building.
- Offer a fallback cache-clear when an admin toolbar module is present but Drush is not.
- Let QA testers reset caches between test runs from the browser.
- Standardize cache clearing across roles on an editorial team.
