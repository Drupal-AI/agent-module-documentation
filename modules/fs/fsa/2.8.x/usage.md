<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fastly Streamline Access adds a user's IP address to a Fastly ACL when they authenticate, so a site protected at the CDN by an IP allow-list can be reached by staff without a VPN or a manual allow-list update.

---

The pattern belongs to hosting platforms — Lagoon in particular, which the permission name reflects — where a non-production environment is shielded at the edge: Fastly holds an ACL of permitted addresses and rejects everything else before the request reaches Drupal. That protects the environment well and makes it awkward to use, because every new location means someone editing an ACL by hand. This module closes the loop: a user with `access protected lagoon routes` authenticates, an event fires, and their address is added to the configured ACL through the Fastly API, with `FsaFastly` and `FsaComms` handling the calls and `FsaEventSubscriber` the trigger. The **project is `fsa` and the module is `fastly_streamline_access`**, so `drush en fsa` fails.

---

- Let staff reach an IP-protected environment.
- Add a developer's IP to a Fastly ACL on login.
- Avoid manual ACL edits.
- Support a Lagoon-hosted staging site.
- Protect a non-production site at the edge.
- Grant access without a VPN.
- Automate allow-listing for a team.
- Reduce friction on a shielded environment.
- Support remote workers changing location.
- Keep an edge ACL current.
- Restrict allow-listing to a permission.
- Support a client review on a protected site.
- Add contractors' addresses temporarily.
- Reduce support requests about access.
- Integrate Drupal login with edge access.
- Manage ACL membership from Drupal.
- Support a multi-environment workflow.
- Combine CDN protection with Drupal auth.
