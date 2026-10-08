<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Link Field provides a multi-value `social_links` field type for storing links to social-media profiles (Facebook, X/Twitter, Instagram, LinkedIn, YouTube and ~20 more), with a widget for entering them and Font Awesome / network-name formatters for displaying them.

---

The module defines a single Drupal field type `social_links` whose each item stores a `social` (platform id) and a `link` (profile URL or handle). The available platforms are pluggable: each is a `SocialLinkFieldPlatform` annotated plugin (in `Plugin/SocialLinkField/Platform/`) carrying the platform id, translated name, Font Awesome icon codes (`icon`, `iconSquare`, `iconSet`), and a `urlPrefix`/`urlSuffix` used to build the final link. A field is added through the normal *Manage fields* UI; the `social_links` widget lets editors pick a platform and enter the profile, with per-widget options to lock the network selection (`select_social`) and disable reordering (`disable_weight`). Two formatters render the value: `font_awesome` (icons, with `icon_type` common/square and `orientation` vertical/horizontal, `new_tab` toggle) and `network_name` (the platform's name as a text link). A single global setting page (`social_link_field.settings`, route `/admin/config/services/social-link-field`, permission "configure social link field") holds one boolean, `attached_fa`, controlling whether the module attaches an external Font Awesome library (turn it off if your theme already ships Font Awesome). Adding a new platform is just dropping a plugin class with the annotation in a custom module.

---

- Add a "Follow us" field of social-media profile links to a Basic page or Article.
- Store an author's social profiles on a user profile or an "Author" content type.
- Display a company's social accounts as Font Awesome icons in a footer block field.
- Render social links as plain network-name text links instead of icons.
- Let editors choose from a fixed set of platforms and just paste their handle.
- Lock the platform selection so editors only fill in the URL for pre-set networks.
- Prevent editors from reordering social links by disabling the weight/drag handles.
- Show square Font Awesome icons instead of the common icons for a branded look.
- Lay out the icons horizontally in a header and vertically in a sidebar.
- Open all social links in a new browser tab via the formatter's "new tab" option.
- Provide default social networks/links on a field so new nodes start pre-populated.
- Add a custom platform (e.g. Mastodon, Bluesky) by writing a small plugin class.
- Override the default Font Awesome icons for a platform purely in your theme CSS.
- Disable the module's bundled Font Awesome when the theme already loads Font Awesome.
- Collect team members' LinkedIn and GitHub links on a "Staff" content type.
- Build a link tree / "linktr.ee"-style block of an organization's channels.
- Capture a musician's Spotify artist / album / playlist links on an event.
- Store an email (mailto) and homepage link alongside social profiles in one field.
- Limit the number of social links per entity via the field's cardinality.
- Migrate legacy separate URL fields into one structured social-links field.
- Present consistent social icons across many content types with one reusable field.
- Configure everything (field, widget, formatter) through exported config for deployment.
