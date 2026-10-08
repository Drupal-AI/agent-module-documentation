Custom Menu Links Visibility lets administrators attach core condition plugins (request path, node type, user role, language, etc.) to individual custom (`menu_link_content`) menu links so a link is shown or hidden in the rendered menu tree based on those conditions. It controls **link display only**, not access to the destination page.

---

The module adds a `visibility` base field to the `menu_link_content` entity (`FieldType`
`menu_link_content_visibility`, a `no_ui` serialized `StringLongItem`) whose widget
(`MenuLinkContentVisibilityWidget`) renders every context-appropriate core **Condition** plugin
in a vertical-tabs UI on the menu-link edit form; the selected condition configurations are
`serialize()`d into the field. At runtime it **overrides the core service**
`menu.default_tree_manipulators` with `MenuLinkContentVisibilityLinkTreeManipulator` (extending
core's `DefaultMenuLinkTreeManipulators`), whose `menuLinkCheckAccess()` first runs the parent
access check, then — for `MenuLinkContent` links, and skipping menu-admin routes
(`_menu_admin`) — unserializes the stored conditions, applies runtime contexts, and evaluates
them with AND logic (`resolveConditions`). If a condition denies, or a required context is
missing/valueless, it returns `AccessResult::forbidden()` (missing *context* also sets
`max-age 0` to avoid caching an unknown result), which removes the link from the tree; condition
cacheability (tags/contexts/max-age) is merged into the access result and the link entity is
added as a cache dependency. `gtag_domain`/`gtag_language` and `current_theme` conditions are
deliberately skipped. **Important:** this is menu-*display* filtering — hiding a link does not
restrict the page it points to; anyone with the URL can still reach the target unless the route
itself enforces access. No permissions, no admin settings page, no config schema, no Drush.

---

- Hide a custom menu link except on specific paths (Request Path condition).
- Show a menu link only on certain content types (Node Type condition).
- Restrict a menu link to specific user roles (User Role condition).
- Show/hide a menu link by interface language (Language condition).
- Combine several conditions on one link (all must pass — AND logic).
- Show an "Admin" link in the menu only to administrator-role users.
- Display a promotional menu link only on the front page.
- Hide a menu link on a set of node types where it is irrelevant.
- Vary main-menu contents per section of the site using path conditions.
- Keep marketing links out of the menu for logged-in members.
- Show a "My account" style link only to authenticated users.
- Apply visibility rules to any custom menu link without writing code.
- Configure conditions through a familiar vertical-tabs form on the menu-link edit page.
- Ensure hidden-link decisions are cache-correct (condition cache metadata is merged in).
- Force a menu link's access to re-evaluate when the link entity is edited (cache dependency).
- Prevent stale caching when a required context is missing (result marked uncacheable).
- Reuse the same core Condition plugins that block visibility uses, but scoped to menu links.
- Curate role-specific navigation menus without cloning menus per audience.
- Suppress a link on non-node routes where its node-type condition cannot resolve.
- Progressively enhance an existing menu with per-link display rules (only affects display).
