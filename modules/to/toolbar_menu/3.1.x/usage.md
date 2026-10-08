Toolbar Menu adds any custom menu (Structure > Menu) to the Drupal admin Toolbar as its own top-level tab, with the menu's links appearing in the tab's tray.

---

Toolbar Menu lets site builders surface arbitrary menus in the administration Toolbar so editors reach the links they use most without digging through the admin tree. Each menu you want in the toolbar is registered as a `toolbar_menu_element` config entity (config prefix `toolbar_menu.toolbar_menu_element.<id>`) carrying an id, a label, the target menu machine name, a weight, and a `rewrite_label` flag. The module implements `hook_toolbar()` to render one `toolbar_item` (tab + tray) per element, ordering them by weight and pre-rendering the selected menu's link tree into the tray. Elements are managed at `/admin/config/user-interface/toolbar-menu/elements` (route `entity.toolbar_menu_element.collection`), which is the module's `configure` route, gated by the `administer toolbar menu` permission. Beyond that admin permission, each element defines its own dynamic permission `view <id> in toolbar`, so you can control which roles see each menu tab. When `rewrite_label` is TRUE the tab displays the underlying menu's own label instead of the element label. It depends only on core Toolbar, and pairs well with Admin Toolbar (suggested) for a richer toolbar. Cache invalidation is handled by a `toolbar_menu` cache tag that is cleared whenever an element is saved.

---

- Put a custom "Editor tools" menu in the toolbar so content editors reach their most-used links in one click.
- Add the Main navigation menu as a toolbar tab for quick front-end link access while administering.
- Expose a curated "Reports" or "Dashboards" menu directly in the admin toolbar.
- Surface a site-section menu (e.g. Products, Events) so editors jump straight to that section's admin pages.
- Give a multi-team site one toolbar tab per team menu, each visible only to that team's role.
- Add a "Quick links" menu of frequently used admin destinations to reduce navigation clicks.
- Provide a Footer or Legal menu in the toolbar for editors who maintain those links.
- Create a per-role toolbar menu using the dynamic `view <id> in toolbar` permission to hide it from other roles.
- Show the underlying menu's own label on the tab by enabling `rewrite_label` instead of maintaining a duplicate label.
- Order multiple toolbar menu tabs by setting each element's weight.
- Build a "Support" menu linking to documentation, issue queues, and contact pages surfaced in the toolbar.
- Add a menu of external tools (analytics, CRM, deployment) as a toolbar tab for the admin team.
- Give store managers a Commerce-related menu tab without granting broader admin toolbar access.
- Combine with Admin Toolbar to nest custom menu links inside the existing admin toolbar experience.
- Deploy toolbar menu tabs as configuration (config entities) across environments via config sync.
- Provide a workflow/moderation menu tab for reviewers to reach content-needing-review lists.
- Add a media library or asset menu to the toolbar for editors who manage media heavily.
- Expose a translations menu tab for multilingual site maintainers.
- Create a "New content" menu of node-add links as a fast-access toolbar tab.
- Give developers a devel/debugging menu tab visible only to the developer role.
- Reduce toolbar clutter by putting a single grouped menu tab instead of many core toolbar items.
- Standardize editor navigation across a site portfolio by shipping the same toolbar_menu elements in a config recipe.
- Add a taxonomy-management menu tab for editors who curate vocabularies.
- Surface a "Settings" shortcut menu for admins who repeatedly visit specific config forms.
- Control tab visibility per environment by enabling/disabling the element's config entity.
