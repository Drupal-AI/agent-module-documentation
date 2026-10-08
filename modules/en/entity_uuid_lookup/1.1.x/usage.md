<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity UUID Lookup provides an admin form, toolbar item and navigation block to enter an entity UUID and be redirected to its canonical/edit URL.

---

Entity UUID Lookup **resolves an entity UUID to its page** — enter any entity's UUID on the admin form and be
redirected to its canonical or edit URL, useful for debugging and support when you have a UUID but not the path.
The form (`/admin/content/by-uuid`) is reachable from an admin content menu link, an admin toolbar item, and a
Navigation-module block. It provides its own permission and lives in the User interface package.

Use it to jump from a UUID to the matching entity. It is an administration/developer convenience: it scans every
entity type that has a `uuid` key, loads the entity, and redirects to the edit or canonical URL only when the
current user has access to that URL. The form itself is gated behind both the "Lookup entities by UUID" and
"View the administration theme" permissions, so grant them only to trusted roles.

---

- Look up an entity by its UUID.
- Redirect to the entity's canonical URL.
- Redirect to the entity's edit form URL.
- Jump from a support-ticket UUID to the node/page.
- Resolve a UUID pasted from a config export or log.
- Debug migrations by resolving migrated-entity UUIDs.
- Find the edit page of any content entity by UUID.
- Reach the lookup from the admin toolbar item.
- Reach the lookup from the admin content menu link.
- Reach the lookup from the Navigation module block.
- Open the lookup in a modal dialog from the toolbar.
- Scan all entity types that expose a `uuid` key.
- Honor entity access when redirecting to the target.
- Gate the form behind admin-only permissions.
- Provide a dedicated "Lookup entities by UUID" permission.
- Aid content editors who work from exported UUIDs.
- Aid developers inspecting entity references.
- Resolve UUIDs for users, taxonomy terms, media, and more.
- Support any entity type with a canonical link template.
- Serve as a lightweight admin/dev utility with no configuration.
