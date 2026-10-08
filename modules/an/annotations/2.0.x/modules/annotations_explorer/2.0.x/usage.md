<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Explorer is a read-only, explorer-style interface for browsing a site's annotations by target.

---

Annotations Explorer provides a lightweight consumer UI at `/annotations/explorer` for browsing annotations grouped by entity type and target, with an AJAX-loaded panel per target (`/annotations/explorer/{annotation_target}`). It is read-only — no create, edit, or delete. Access is granted to any user who can consume at least one annotation type (`ExplorerController::access()` checks `loadAccessibleTypes()`), and the displayed content is filtered to the types that user may consume. Depends on `annotations`; suggests diff for revision comparison.

---

- Browse a site's annotations in an explorer-style layout.
- Group annotations by entity type and target.
- Load a target's annotations into a panel via AJAX.
- Filter shown annotations to the viewer's consumable types.
- Grant access to anyone who can consume at least one annotation type.
- Offer a read-only view with no write surface.
- Give reviewers a quick way to see what's documented.
- Navigate between targets without full page reloads.
- Escape target labels and machine names on output.
- Complement the management UI (annotations_ui) for consumption.
- Provide a low-friction entry point for editors to discover guidance.
- Show machine names alongside human labels for orientation.
- Work with only the base annotations module installed.
- Support revision diff display when the diff module is present.
- Serve as a browseable alternative to the JSON/MCP context endpoints.
- Keep output cache-varied by user permissions.
