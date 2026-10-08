<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Help Scout Beacon embeds the Help Scout Beacon support/help widget onto the site by attaching its JavaScript, keyed to a configured Beacon form id.

---

Help Scout's Beacon is a client-side widget that puts a contact/help button on the page so visitors can search docs, start a chat, or open a support conversation. This module wires that widget into Drupal: an admin enters the Beacon **form id** on a settings form, and the module exposes it to the front end via `drupalSettings` and attaches the `help_scout_beacon/help_scout_beacon_renderer` JS library that boots the Beacon.

Two access gates apply. The settings form at `/admin/config/services/help-scout-beacon/settings` requires the `administer help scout beacon settings` permission. The widget itself is only attached for users who have the `use help scout beacon` permission — so you can show the Beacon to, say, authenticated users or a support role while hiding it from anonymous traffic (grant the permission to the anonymous role to show it to everyone). The Beacon form id is a public, client-side embed identifier by design; it is not a secret and no API key or credential is stored or exposed by the module.

Setup: create a Beacon in Help Scout and copy its form id, enable the module, grant `use help scout beacon` to the roles that should see the widget, then paste the id on the settings form. (Note: the info.yml `configure` link points at `help_scout_beacon.setting`, but the actual route name is `help_scout_beacon.settings`.)

---

- Add a Help Scout Beacon contact/help button to the site
- Configure the Beacon form id from the Drupal admin UI
- Show the Beacon only to logged-in users via the `use help scout beacon` permission
- Show the Beacon to everyone by granting the permission to anonymous
- Restrict the Beacon to a support/staff role only
- Restrict who can change the Beacon id with a dedicated admin permission
- Swap the embedded Beacon by changing the form id
- Offer in-page docs search and live chat through Help Scout
- Let visitors open support conversations without leaving the page
- Provide contextual help on selected user roles' pages
- Disable the widget site-wide by revoking the use permission
- Keep the support widget config in exportable Drupal configuration
- Integrate an existing Help Scout mailbox's Beacon into Drupal
- Roll the Beacon out to a staging role before enabling site-wide
- Attach the Beacon JS only where the use permission is granted (no anonymous overhead otherwise)
