<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shortcut Menu turns Drupal's flat shortcut sets into a nestable menu: shortcuts gain a parent, so a set can be organised into groups and sub-items like an ordinary menu rather than one long list.

---

Core's Shortcut module stores each shortcut as a flat entity in a set, which stops being useful once an editor has more than a handful. This module extends the entity rather than replacing it: `hook_entity_base_field_info()` adds a parent field to the `shortcut` entity so links can point at another shortcut, and `hook_entity_type_build()` swaps in the module's own form class, `ShortcutMenuSetCustomize` (extending core's `SetCustomize`), which renders the customise screen as a draggable, indentable tree instead of a flat table. Rendering is handled by `ShortcutMenuLazyBuilder`, a subclass of core's `ShortcutLazyBuilders`, so the toolbar's lazy-built shortcut list reflects the hierarchy while keeping core's caching behaviour. A small CSS library styles the nested list in the toolbar. There is no configuration form, no permissions and no schema of its own — it works entirely through the existing shortcut UI and permissions. The installed release is a beta (`3.0.0-beta8`), so treat the parent-field schema as still settling.

---

- Group admin shortcuts into folders instead of one long list.
- Nest related shortcuts under a parent item.
- Organise a large shortcut set by team or task.
- Give editors a shortcut tree that mirrors the admin menu.
- Reduce toolbar clutter on a complex site.
- Keep shortcuts usable when a site has dozens of admin pages.
- Reorder and re-parent shortcuts by dragging.
- Provide a role-specific shortcut set with structure.
- Build a task-oriented shortcut hierarchy for occasional users.
- Keep core shortcut permissions and sets unchanged.
- Preserve toolbar caching behaviour while adding hierarchy.
- Style the nested shortcut list with the shipped CSS.
- Migrate an existing flat set into a nested one.
- Group content, configuration and reporting shortcuts separately.
- Give new staff a guided shortcut structure.
- Avoid building a custom admin menu module.
- Support multiple nested shortcut sets per site.
- Collapse rarely used shortcuts under a parent.
- Keep the shortcut entity type intact for other integrations.
- Trial nesting on one shortcut set before rolling it out.
