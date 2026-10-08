Smart Title UI is the optional admin submodule for Smart Title. It adds a settings page where you tick which entity types and bundles should be Smart-Title-eligible; the parent module does the actual title rendering.

---

Smart Title UI provides a single configuration form at `/admin/config/content/smart-title` (route `smart_title_ui.settings`, permission `administer smart title`). The form lists every content entity type whose label is not already display-configurable, grouped by entity type, with a checkbox per bundle. Saving writes the selected `entity_type:bundle` strings into the parent module's `smart_title.settings` config and, for any bundle that was unchecked, removes the now-orphaned Smart Title third-party settings from that bundle's view displays. It also invalidates the `entity_field_info` cache so the `smart_title` extra field appears or disappears on *Manage display*. The submodule stores no config of its own — it is purely a management UI over `smart_title.settings` — and can be safely disabled on production once bundles are configured (the parent module keeps working from the stored config).

---

- Open `/admin/config/content/smart-title` to choose which bundles get Smart Title.
- Enable Smart Title for the Article content type with a single checkbox.
- Enable it for multiple content types (nodes, taxonomy terms, media) at once.
- Disable Smart Title for a bundle and have its view-display settings cleaned up automatically.
- Grant editors the `administer smart title` permission to manage eligibility.
- Provide a click-through alternative to editing `smart_title.settings` by hand.
- Review at a glance which entity types support Smart Title on this site.
- Turn a bundle on, then configure its per-view-mode title on Manage display.
- Bulk-enable Smart Title across every bundle of an entity type.
- Remove a bundle from Smart Title and drop its stored title settings in one save.
- Keep the admin UI out of production by enabling it only when reconfiguring.
- Restrict who can change Smart Title eligibility via the dedicated permission.
- Discover the set of eligible entity types (those without an already-configurable label).
- Re-expose the smart_title extra field after enabling a bundle (cache is invalidated on save).
- Manage Smart Title eligibility without touching exported config files.
