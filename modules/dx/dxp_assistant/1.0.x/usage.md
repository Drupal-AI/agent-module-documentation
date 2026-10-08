<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Loads a remote DXP (Digital Experience Platform) assistant script into your Drupal site's pages for permitted users.

---

DXP Assistant adds an external assistant's JavaScript to your site by injecting a `<script src>` tag into the HTML head. In the shipped 1.0.0-alpha1 release the entire behaviour is: an administrator enters a Script URL on the module's settings form (`/admin/config/user-interface/dxp-assistant`), and `hook_page_attachments()` then attaches that script to every page — but only when the current user has the `access dxp assistant` permission and the stored URL is valid. It is an early, minimally maintained work-in-progress: there is no controller, no HTTP data endpoint, no `drupalSettings` output, no declared JS library, and no API-key or credential handling in this release. The URL is kept as a plain string in the `dxp_assistant.configuration` config object. Requires Drupal 10.4+ or 11; no module or Composer dependencies.

---

- Load a hosted DXP assistant / help overlay onto your Drupal site.
- Inject a third-party assistant script tag site-wide via `hook_page_attachments()`.
- Point the site at a specific assistant build by setting its Script URL.
- Restrict who sees/uses the assistant with the `access dxp assistant` permission.
- Limit configuration access with the `administer dxp assistant` permission.
- Change the assistant script URL without editing code (admin form only).
- Serve the assistant only to authenticated staff by granting the permission to specific roles.
- Serve the assistant to anonymous visitors by granting the permission to the anonymous role.
- Turn the assistant off site-wide by clearing the Script URL field.
- Turn the assistant off for a role by revoking `access dxp assistant`.
- Manage the assistant from the admin UI at Configuration → User interface → DXP Assistant.
- Store the assistant script location in exportable Drupal configuration.
- Ship the assistant URL between environments through config sync.
- Vary the loaded assistant per role via permission grants.
- Integrate a Digital Experience Platform assistant into an existing Drupal install.
- Prototype/evaluate a DXP assistant integration (pre-release/alpha).
- Add the assistant to a subset of users during a phased rollout.
- Rely on Drupal's permission cache context so the script only renders for permitted users.
- Remove the module cleanly (no schema install, no external services required).
