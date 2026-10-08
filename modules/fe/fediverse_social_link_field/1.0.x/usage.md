<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Fediverse platforms (a generic Fediverse option plus Mastodon, Lemmy and Hubzilla) to the Social Link Field module so editors can attach these profile links to entities.

---

Fediverse Social Link Field is a thin extension of the contributed Social Link Field module. It contributes four `SocialLinkFieldPlatform` plugins - `fediverse`, `mastodon`, `lemmy` and `hubzilla` - each of which is an empty class carrying only annotation metadata (plugin id, translated label, a Font Awesome icon and square icon, and the `https://` URL prefix). Once enabled alongside its hard dependency `social_link_field`, these platforms appear in the Social Link Field widget's network selector and render through Social Link Field's existing field type, widget and formatters. The module itself provides no forms, routes, permissions, services, config or Drush commands, and needs no configuration; all field behaviour and output come from the parent module.

---

- Let editors add a Mastodon profile link to a content type, user profile or other entity via a Social Link Field.
- Add a link to a Lemmy community or account on author bios.
- Surface a Hubzilla channel link in a site footer or contact block field.
- Offer a generic "Fediverse" option for ActivityPub services not covered by a dedicated platform.
- Extend an existing Social Link Field so its list of networks includes decentralized/Fediverse options next to Twitter, Facebook, etc.
- Restrict a specific field instance (via Social Link Field's per-field "platforms" setting) to only Fediverse networks.
- Build a "Follow us on the Fediverse" set of icon links for an organization page.
- Display Mastodon/Lemmy/Hubzilla icons using Social Link Field's Font Awesome formatter.
- Show plain network-name links to Fediverse profiles using Social Link Field's network-name formatter.
- Present Fediverse links vertically or horizontally using the parent formatter's orientation setting.
- Open Fediverse profile links in a new tab using the parent formatter's "new tab" setting.
- Collect multiple Fediverse handles (e.g. several Mastodon instances) on one multi-value field.
- Add Fediverse links to team/staff member nodes for social discovery.
- Provide Fediverse contact points on event or project pages.
- Include Mastodon/Lemmy links in a taxonomy term description area via an attached field.
- Migrate a site away from centralized-only social links by enabling decentralized alternatives.
- Populate Fediverse profile links on user registration/profile edit forms.
- Give site builders a ready-made Fediverse network set without writing custom platform plugins.
- Combine Fediverse platforms with the parent module's other social networks on a single field.
- Theme Fediverse social links using the parent module's `social-link-field-formatter` template.
