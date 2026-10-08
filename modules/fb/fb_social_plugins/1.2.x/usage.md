<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facebook Social Plugins integrates Facebook's Like button, Share button, Page plugin, and Comments plugin into a Drupal site. Each plugin is available both as a placeable block and as an extra display field that can be enabled per content-entity bundle, rendered using Facebook's JS SDK.

---

- Requires core `block`; Drupal 8, 9, or 10.
- Enable with `drush en fb_social_plugins`.
- Configure at `/admin/fb-social-plugins` (permission: "access fb social plugins config", restricted) — separate settings forms for Like, Share, Page plugin, and Comments.
- In each settings form, choose which entity types the plugin is active on (stored as `entities.<entity_type_id>`) and layout/size options.
- Place the Like/Share/Page/Comments blocks via Block Layout, or enable the corresponding extra field on a bundle's "Manage display".
- Facebook's SDK library (`fb_social_plugins/facebook`) is attached where a plugin renders.

---

- Add a Facebook Like button to nodes/entities or as a block.
- Add a Facebook Share button that links to the sharer dialog.
- Embed a Facebook Page plugin (timeline/messages/events tabs).
- Embed a Facebook Comments plugin tied to the current page URL.
- Enable a plugin per entity type via configuration.
- Show plugins as extra fields on "Manage display".
- Configure layout, width, button size, and action type for Like.
- Configure page URL, tabs, height, header/cover options for the Page plugin.
- Configure number of posts and width for Comments.
- Use the current page's absolute URL automatically for Like/Share/Comments.
- Place plugins as blocks in any region.
- Restrict settings access with a dedicated permission.
- Attach the Facebook JS SDK only where needed.
- Combine multiple plugins on one page.
- Remove all plugin config cleanly on uninstall.
- Theme each plugin via its own Twig template.
