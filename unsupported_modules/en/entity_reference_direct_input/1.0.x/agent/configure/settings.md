<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_reference_direct_input — settings & resolution

## Enable per entity type
`/admin/config/content/entity-reference-direct-input` (permission `administer site configuration`) → config `entity_reference_direct_input.settings:enabled_entities`. Only Node, User and Taxonomy Term are supported; direct input activates only for types in this list.

## Accepted input forms (`resolveToEntityId()`)
1. `123` or `#123` → that entity ID.
2. Email (User only) → looks up `user` by `mail`.
3. Full `http(s)://…` URL → reduced to its path.
4. Path/alias → normalised (base path stripped, urldecoded) → `getUrlIfValidWithoutAccessCheck()`; if routed to `entity.node|user|taxonomy_term.canonical`, extracts the ID.
5. Fallback regexes for `/node/N`, `/user/N`, `/taxonomy/term/N`.

## Behaviour
- Core label matches come first; the resolved match is prepended as `Label (id)` with a human label `Label — alias (id: N)`.
- The field's `target_bundles` restriction is enforced before a match is injected.
- Note: step 4 intentionally skips a view-access check when converting a path to an ID; downstream reference/entity access still applies.
