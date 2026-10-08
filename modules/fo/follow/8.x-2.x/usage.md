<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Follow provides configurable links to social-network profiles, both a sitewide set and per-user sets, exposed as blocks with icons.

---

A site-wide settings form (follow.settings, perm 'manage follow settings') lets admins define the network links shown in the sitewide Follow block. Individual users can add their own profile links via /user/{user}/follow (custom access with 'edit own follow links' / 'edit any user follow links'), rendered through a per-user Follow block. Links and their data are stored with the user.data service and managed by the follow.manager service. A view field plugin exposes follow links to Views, and templates/icons are provided and overridable. Permissions gate managing settings, editing own vs any user's links, and viewing links. Use it to surface 'follow us on social media' calls-to-action or to let community members share their own profiles.

---

- Show a sitewide 'Follow us' block linking to your social profiles.
- Let each user list their own social network links on their profile.
- Display follow icons for Twitter/X, Facebook, LinkedIn, etc.
- Add per-user social links to community member profiles.
- Render follow links in a Views listing via the field plugin.
- Grant editors 'edit any user follow links' to curate profiles.
- Allow users to manage only their own follow links.
- Place the sitewide follow block in the footer.
- Override follow templates to match your theme.
- Swap in custom icons for supported networks.
- Provide a consistent social CTA across all pages.
- Expose author social links on article bylines.
- Restrict who can change the sitewide follow settings.
- Show followers where to connect off-site.
- Localize or theme follow labels per network.
- Build a directory of members with their social links.
