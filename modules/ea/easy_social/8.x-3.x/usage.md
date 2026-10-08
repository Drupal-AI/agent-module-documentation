<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Social adds a configurable set of social share buttons — Twitter/X, Facebook, LinkedIn, Pinterest and a plain email link — that you place on your content.

---

Install the module the usual way (`composer require drupal/easy_social` then enable **Easy Social**; it depends on nothing and supports Drupal `^9 || ^10 || ^11`, current release **8.x-3.2**). Grant the **Administer Easy Social** permission (`administer easy_social`) to the roles that should configure it — it is deliberately restricted. Configuration lives at **Administration → Configuration → Web services → Easy Social** (`/admin/config/services/easy-social`): the main tab picks which networks are globally enabled and whether their JavaScript loads asynchronously, and one tab per network (Twitter, Facebook, LinkedIn, Pinterest, Email) sets that network's options — for example Twitter `via`/`hashtags`/button size, Facebook layout and colour scheme, the LinkedIn counter, the Pinterest description, and the Email button's label, subject and body. To make the buttons appear you either place the **"Easy Social"** block in a region through Block Layout, or turn on the **"Easy Social widgets"** field on a content type's **Manage display** tab (available for content, comments, files, taxonomy terms and users). The same enabled-widgets set is used everywhere it is shown. Each official network button loads that network's own third-party script in the visitor's browser (`platform.twitter.com`, `connect.facebook.net`, `platform.linkedin.com`, `assets.pinterest.com`); the Email button is a pure `mailto:` link with no external code. Developers can add their own buttons with `hook_easy_social_widget()` (plus a matching `easy_social_<name>` theme hook and template) and adjust the entity types the display field attaches to with `hook_easy_social_supported_entity_alter()`; the bundled **Easy Social Example** submodule shows the full pattern.

---

- Add social share buttons to articles and blog posts.
- Let readers post a page to Facebook.
- Let readers share to LinkedIn.
- Add a Pinterest "Pin it" button to image-heavy content.
- Offer a Tweet / share-to-X button.
- Add a "share by email" link that opens the visitor's mail client.
- Choose exactly which networks appear site-wide.
- Set the Twitter attribution (`via`) and default hashtags.
- Configure the Facebook button layout, width and colour scheme.
- Configure the LinkedIn share counter position.
- Preset a Pinterest description for pins.
- Customise the email button label, subject line and body text.
- Place the share buttons in a sidebar or footer region via a block.
- Show share buttons automatically on every node of a content type.
- Enable share buttons on comments, taxonomy terms, files or user profiles.
- Restrict who can change the sharing configuration to specific roles.
- Load the widget JavaScript asynchronously for performance.
- Standardise one share-button set across the whole site.
- Replace hand-coded, per-theme share markup with managed configuration.
- Add sharing to a news, marketing or campaign site.
- Support sharing on mobile as well as desktop.
- Build a bespoke share button for a network not included by default.
- Rename or remove a bundled widget from code.
- Extend sharing to custom entity types.
- Prototype a custom widget quickly from the Easy Social Example submodule.
