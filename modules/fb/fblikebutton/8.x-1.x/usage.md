<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facebook Like Button automatically renders a configurable Facebook Like button on chosen content types and provides a separate block containing a Like box.

---

Facebook Like Button (package Social) embeds Facebook's official Like social plugin so visitors can like a
page or the whole site without an editor pasting Facebook's embed code by hand. It works two ways. A
per-node **dynamic** button is attached through `hook_entity_extra_field_info()` and `hook_node_view()` as
an extra display field (`fblikebutton`) on each content type enabled on the settings form; when the display
component is placed and the viewer has the `access fblikebutton` permission, the node's own absolute
canonical URL becomes the like target. A **block** plugin (`FblikebuttonBlock`, id `fblikebutton_block`)
provides a Like box that can point at a fixed URL (your homepage or a Facebook page), or at `<current>` to
like the page currently being viewed. Appearance is centrally configured in `fblikebutton.settings`
(content types, layout, size, action verb, color scheme, language, width) and the block also carries its own
per-instance copy of those appearance options plus its target URL. Rendering goes through one Twig template,
`templates/fblikebutton.html.twig`, which loads Facebook's SDK (`connect.facebook.net/<language>/sdk.js`) and
emits the `<div class="fb-like" data-href="…">` markup. The module ships config plus schema, two permissions
(`administer fblikebutton`, `access fblikebutton`), an admin form at
`/admin/config/user-interface/fblikebutton`, and requires no other modules or PHP libraries. Note that a Like
target needs a publicly reachable URL for Facebook to fetch, so the button may not render on a local site.

---

- Add a Facebook Like button to nodes of selected content types automatically, without editing each node.
- Let visitors like the exact page (node) they are viewing via the dynamic per-node button.
- Place a site-wide Like box block that likes a fixed URL such as your homepage.
- Point a Like box block at a specific Facebook page or any external URL.
- Configure a block to like the current page using the `<current>` token instead of a fixed URL.
- Choose which content types show the button on the `fblikebutton.settings` form.
- Restrict who can see the button using the `access fblikebutton` permission per role.
- Switch the Like widget layout between standard, box count, button count, and button.
- Set the button size to small or large.
- Show either a "Like" or a "Recommend" verb on the button.
- Pick a light or dark color scheme to match your theme.
- Localize the widget by setting a Facebook locale code (e.g. `fr_FR`, `fr_CA`).
- Set a pixel width for the standard-layout plugin.
- Place the Like button as an extra field via the content type's Manage display screen.
- Show the button on teasers as well as full node views by enabling its display component in a view mode.
- Add social sharing/engagement to a content site without custom code or a third-party library.
- Override the widget markup by copying `fblikebutton.html.twig` into your theme.
- Give content editors a Like button without granting them extra text-format permissions.
- Add multiple Like box blocks in different regions, each with its own URL and appearance.
- Run the module on Drupal 8.8 through 11 with no module dependencies.
- Reuse Facebook's official SDK so the widget stays current as Facebook updates its service.
- Clear the render cache automatically after enabling the module or saving settings.
