Required Menu Link lets you make a menu link mandatory per content type: when enabled on a content type, the node form's Menu link is forced on and its title becomes required, so every node of that type must have a menu link.

---

The module is entirely `hook_form_alter`-driven, with no settings page (`configure` null), no permissions, and no services. On the node type add/edit form it adds a "Menu link settings" vertical tab (`require_menu` details group) with three checkboxes stored as node-type third-party settings under the `required_menulink` namespace: `require_menulink` (enforce a menu link for every node of the type), `soft_require` (only pre-enable the menu link by default without forcing it), and `disable_auto_menutitle` (stop core from auto-copying the node title into the menu title). An entity builder (`required_menulink_nodetype_entity_builder`) persists these settings. On the node edit form (`required_menulink_form_node_form_alter`) it reads the content type's settings: when `require_menulink` is on and `soft_require` is off, it opens the menu fieldset, disables and force-checks `menu[enabled]` (`#value = 1`), and marks the menu link title `#required`; when `soft_require` is on it merely defaults the checkbox to enabled. When `disable_auto_menutitle` is set it attaches a small JS behavior (`menu_ui.required_menulink`) that flags the menu title as "manually overridden" so core stops mirroring the node title. A second JS library (`content_types`) just updates the vertical-tab summary. A config schema describes the three third-party setting keys. The enforcement is UI-level (form `#required`/`#disabled`), not an entity-level constraint, so it applies to the standard node form path.

---

- Force every node of a content type to have a menu link (e.g. all landing pages must be in a menu).
- Make the menu link title a required field on specific content types.
- Pre-enable the menu link checkbox by default without strictly enforcing it (soft require).
- Nudge editors to notice the menu link by opening the menu fieldset automatically.
- Disable core's automatic copying of the node title into the menu link title.
- Require menu placement for navigational content types while leaving others optional.
- Ensure a documentation/section content type always appears in the site menu tree.
- Prevent editors from saving a page that should be in a menu without setting one.
- Keep menu link titles meaningful by forcing editors to type them (with auto-title disabled).
- Apply different menu-link requirements per content type from the content type edit form.
- Guarantee breadcrumb/menu-based navigation works by mandating menu links on key types.
- Default new nodes of a type to "provide a menu link" checked to save editor clicks.
- Combine hard-require on one type and soft-require on another within the same site.
- Stop menu titles from silently defaulting to the (possibly long) node title.
- Enforce menu placement policy without writing custom validation code.
- Configure the requirement entirely from admin/structure/types/manage/<type>.
- Ensure child pages are always attached to a parent menu item for a hierarchical menu.
- Remove the requirement later by unchecking the setting (third-party settings are cleared).
- Provide a consistent authoring experience where menu placement is part of the required flow.
- Make menu links required on newly created content types via the same vertical tab.
