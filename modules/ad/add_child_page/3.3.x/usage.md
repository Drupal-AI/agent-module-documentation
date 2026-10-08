Add Child Page adds "Add Child Page" links/tabs to nodes that appear in a menu, redirecting the editor to the node add form with the new node's menu parent pre-selected under the current page — a lightweight way to build book-like page hierarchies through menus. It also adds a "Child Pages" tab listing a node's existing menu children.

---

On configured content types the module surfaces an "Add Child Page" action/tab (via
`hook_entity_operation()`, action links, local tasks, and optionally a button on the node form). Following
it hits `AddChildPage::manage()` (route `node/{node}/child`), which finds the node's menu link, then
redirects to `node.add` for the target content type with `?plid=<parent uuid>&menu=<menu>` query params
(if the node is on several menus it uses the first and warns). `hook_form_alter()` reads those query params
on the node add form and pre-sets the Menu settings (enabled, parent, weight) so the new node is created as
a child in that menu. A configuration form (`/admin/config/content/add-child-page`, permission `administer
content types`) selects which content types show the feature, whether to show a content-type selector first
(`AddChildPageSelectForm`, opened in a modal) or default to the parent's type / a fixed default type, and
where the entry points appear (node view, edit, tab, node form, child-pages tab). A "Child Pages" section
(`node/{node}/children` and `node/{node}/children/{menu}`, permission `access add child page` +
`administer menu`) lists and reorders the node's menu children per menu. All content-facing routes require
the `access add child page` permission plus a custom access check that the node's bundle is in the
configured list. Requires the Token module. Node creation itself still goes through core's node add form,
so normal node-create access applies.

---

- Add a child page to a node directly from its view page, with the menu parent pre-filled.
- Build a book-like page hierarchy using menus instead of the Book module.
- Let editors create sub-pages without manually setting the menu parent each time.
- Restrict the "Add Child Page" feature to specific content types.
- Show a content-type chooser before creating the child (or skip it and default to a type).
- Default the child page to the same content type as its parent.
- Force all child pages to a single content type regardless of the parent.
- Place the "Add Child Page" entry on the node view page as an action link.
- Place it on the node edit page or as a primary tab.
- Add an "Add Child Page" button next to Save/Preview on the node form.
- Open the content-type selector in a modal dialog.
- List a node's existing menu children on a "Child Pages" tab.
- Show child pages grouped per menu when a node appears in multiple menus.
- Reorder a node's menu children from the Child Pages screen.
- Warn editors when a node is on more than one menu (defaults to the first).
- Pre-set the new child's menu weight to sort after existing siblings.
- Keep child creation menu-aware across content translations (language-correct URLs).
- Gate the feature with the dedicated `access add child page` permission.
- Manage which entry points appear via configuration toggles, no code.
- Provide a quick sub-page workflow for marketing/landing-page trees.
- Use Token (dependency) alongside menu-driven page structures.
- Add children under a specific menu chosen from the node's menus.
