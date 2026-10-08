<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Type Tray replaces Drupal's plain `/node/add` list with a grouped, illustrated "tray": content types organised into categories, each with an icon, a thumbnail, a rich extended description, a weight and a per-user favourites list.

---

The module takes over core's `node.add_page` route through a route subscriber (priority 95 on `RoutingEvents::ALTER`) that repoints the controller at `TypeTrayController::addPage()`, a subclass of core's `NodeController`. Categories are defined once, globally, in `type_tray.settings` — a `categories` sequence of `machine_name: Label` pairs entered on the settings form as `key|label` lines, plus a `fallback_label` for uncategorised types (default *Uncategorized*, key `_none`) and a `text_format` used for extended descriptions. Everything per content type is stored as **third-party settings** on the `node_type` config entity under the `type_tray` namespace: `type_category`, `type_icon`, `type_thumbnail`, `type_description`, `existing_nodes_link_text` and `type_weight`; a `hook_form_BASE_FORM_ID_alter()` adds them as a "Type Tray" vertical tab on the content-type edit form and an entity builder writes them back. At render time the controller filters types by `create` access, groups them by category in the order the categories were configured (uncategorised always last), sorts within a group by weight, and builds one `type_tray_teaser` render element per type inside a `type_tray_page` element, falling back to bundled Feather icons and demo thumbnails when none are set. Two layouts are available via the `?layout=grid|list` query parameter — `list` shows the thumbnail and the extended description, `grid` shows the icon and the short description. Authenticated users can star a type: a CSRF-protected route writes into the `type_tray_favorites` key-value collection keyed by uid and a synthetic *Favorites* group is prepended. The settings form refuses to delete a category that is still assigned to a type, and both the form and the favourites route invalidate the `config:node_type_list` cache tag.

---

- Group 30 content types into "Editorial", "Marketing" and "Landing pages" so authors find the right one.
- Give each content type a distinctive icon on the *Add content* page.
- Show a full-page screenshot thumbnail of what each content type looks like when published.
- Write a long, formatted explanation of when to use a content type, shown in list layout.
- Keep the short core description for the compact grid layout and a richer one for the list.
- Add a "View existing Article content" link straight to a filtered `/admin/content`.
- Hide that link for a type by leaving its link text empty.
- Order the most-used content types first inside a category with `type_weight`.
- Control the order the category groups appear by ordering the lines on the settings form.
- Rename the catch-all group from "Uncategorized" to e.g. "Other content".
- Let each editor pin their own frequently used types to a personal Favorites group.
- Choose which text format editors may use for extended descriptions.
- Onboard new authors faster by making the node-add page self-documenting.
- Keep `/node/add` respecting per-type create access — types a user cannot create never appear.
- Link to the grid or list layout directly with `?layout=list`.
- Ship the whole configuration through config management (`type_tray.settings` + `node.type.*`).
- Use theme-provided artwork by pointing `type_icon` at `/themes/custom/foo/icons/bar.svg`.
- Fall back to the bundled Feather icon and demo thumbnail for types you have not styled yet.
- Prevent accidental removal of a category that content types still reference.
- Restrict who can change the tray with the `administer type tray` permission.
- Override `type-tray-page.html.twig` / `type-tray-teaser.html.twig` in a custom theme.
- Translate category labels through interface translation (labels are passed through `t()`).
- Audit which category a type is in with `drush cget node.type.<type> third_party_settings`.
- Give a content-type inventory to stakeholders as a visual page rather than a bare list.
- Clear the favourites of a user by deleting their entry from the `type_tray_favorites` key-value collection.
