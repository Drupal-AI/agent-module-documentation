<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site provides a `site` entity representing this Drupal website — its Drupal/PHP versions, Git info, and an overall "Site State" (OK / Warning / Error) with a reason — that is revisionable, fieldable, and exposed over a JSON:API so a central Site Manager can collect it.

---


State is computed by pluggable SiteState/SiteProperty plugins (core Status report, Site Audit, or custom), and the module shows a status indicator in the admin toolbar plus Status/History/Settings/Edit pages under `/admin/site`. Snapshots (revisions) are saved on config changes or cron and can be POSTed to a remote data destination; a remote receiver can optionally override selected config/fields/state via the Site Overrides mechanism. A Site API (`/jsonapi/self`, `/jsonapi/action/{plugin_id}`) supports basic_auth, cookie, key_auth, and IP-consumer auth, each behind a permission, and pluggable Site Actions can be executed. It is part of the Drupal Operations Platform.

Setup: enable the module (and its deps), open `/admin/site/about`, configure which state handlers and config/state values are stored, and optionally set a remote destination for reporting.
---
- Track this site's Drupal/PHP versions and Git info.
- Compute an overall Site State (OK/Warning/Error).
- Show a site-status indicator in the admin toolbar.
- View the Site Status page at `/admin/site/about`.
- Save a status snapshot (revision) on demand.
- Review site history via entity revisions.
- Store selected config and State values in the entity.
- Add custom fields to the Site entity.
- Expose site data over JSON:API (`/jsonapi/self`).
- Authenticate the Site API with key_auth or basic auth.
- POST site data to a remote Site Manager.
- Receive and override config/fields from a remote site.
- Run pluggable Site Actions (`/jsonapi/action/{plugin_id}`).
- Write a custom SiteState/SiteProperty plugin.
- Set state/reason from scripts via Drush.
- Refresh site data on cron.
- Restrict Site API access with dedicated permissions.
- Manage Site entity fields, form, and display.
- Use HTTP status code as a lightweight health signal.
- Integrate with the Drupal Operations Platform dashboard.
- Add a site from a project page.
