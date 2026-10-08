<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Direct Input lets content editors resolve an autocomplete entity reference by typing raw identifiers instead of hunting for a label.
---
It replaces core's `entity.autocomplete_matcher` (via a service provider) with a matcher that first returns core's normal label matches, then — for entity types enabled in configuration — tries to resolve the raw string to an entity: a numeric ID or `#123`, a user email address (users only), a full `http(s)://` URL, or a path/alias, which it maps to node/user/taxonomy_term canonical routes. When it resolves, it prepends a "Label — /alias (id: N)" suggestion. Supported types are Node, User and Taxonomy Term; per-type enabling is set at `/admin/config/content/entity-reference-direct-input` (permission: `administer site configuration`).

The matcher honours the field's `target_bundles` restriction before injecting a match, so it cannot broaden the allowed set. Path resolution uses `getUrlIfValidWithoutAccessCheck()`, so URL/alias resolution deliberately ignores view access when turning a path into an ID — but the resolved entity is still subject to the reference field's own selection handler and, ultimately, the entity's access on render/save; the widget only augments suggestion matching.
---
- Paste a node URL to set an entity reference
- Type a bare node ID (e.g. 123) to reference it
- Use #123 shorthand in an autocomplete field
- Reference a user by their email address
- Resolve a path alias to the underlying entity
- Enable direct input only for Node references
- Enable direct input for User reference fields
- Enable direct input for Taxonomy Term fields
- Speed up bulk referencing when editors know IDs
- Respect a field's target-bundle restriction while pasting IDs
- Convert a copied canonical URL into a reference value
- Turn an aliased path into a term reference
- Fall back to core autocomplete label search when input isn't an ID
- Configure enabled entity types at the settings page
- Reference content by ID during migration cleanup
- Let editors paste full URLs from another browser tab
- Match subdirectory-install paths by stripping the base path
