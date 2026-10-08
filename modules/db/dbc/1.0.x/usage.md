<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Base Css lets a multi-domain site load a different CSS file for each domain.

---

Built on the Domain module, it adds an admin settings form at `/admin/config/domain/domain_css_switcher` (route `dbc.settings`, guarded by the `administer domain css switcher setting` permission requirement) with one `managed_file` upload field per configured Domain entity, restricted to `.css` files stored under `public://dbc/`. On every request, `hook_page_attachments_alter()` in `dbc.module` resolves the active domain via the `domain.negotiator` service, reads the file id saved for that domain from the `dbc.settings` config object (key `uploaded_css_uploader_<domain_id>`), loads the `File` entity, and appends a `<link rel="stylesheet">` to the page head pointing at the file's absolute URL. If the Domain module is not enabled, or no domains are configured, it only writes a notice to the `dbc` logger and attaches nothing.

The module is purely additive theming: its single route is the settings form, and it exposes no plugins, services, entities, config schema, or Drush commands. Setup is: enable Domain, grant the permission requirement, upload one CSS file per domain on the settings form, and clear caches if a change does not appear.

---
- Give each affiliate domain its own look with a dedicated CSS file.
- Upload a per-domain stylesheet from the admin settings form.
- Override base-theme colours only on one domain of a multi-domain farm.
- Serve seasonal or campaign CSS to a single domain without a subtheme.
- Keep uploaded CSS in `public://dbc/` for easy inspection.
- Add a stylesheet to the head automatically on every page of a domain.
- Swap a domain's stylesheet by re-uploading the managed file.
- Distinguish staging vs production affiliates visually via CSS.
- Brand partner microsites differently while sharing one Drupal install.
- Apply print or accessibility tweaks scoped to a single domain.
- Layer domain CSS on top of the active theme rather than replacing it.
- Verify the active domain is detected by checking the emitted `<link>` tag.
- Remove a domain's custom CSS by clearing its upload field on the form.
- Rely on `.css` upload validation so non-CSS files are rejected.
- Audit which domains have custom CSS from the settings form.
- Pair with Domain Access to align styling with content scoping.
- Confirm the `domain.negotiator` picks the expected active domain per host.
- Troubleshoot missing CSS by clearing render/page caches.
- Read the `dbc` logger channel when no stylesheet is attached to diagnose why.
- Scope a temporary A/B visual test to one domain via its CSS upload.
