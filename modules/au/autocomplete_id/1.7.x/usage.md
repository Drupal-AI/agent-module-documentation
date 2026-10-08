<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autocomplete Entity ID extends Drupal's core entity autocomplete so users can find and pick a referenced entity by typing its numeric entity ID, not only its label.

---

The module ships three cooperating pieces on top of core's entity autocomplete. First, a `entity_id_autocomplete` form element (`Element\EntityIdAutocomplete`, extending core `EntityAutocomplete`) that swaps in the module's own autocomplete route and adds an `#element_validate` handler which can resolve a typed ID to a target entity. Second, a field widget `entity_reference_autocomplete_id` (`EntityReferenceAutocompleteIdWidget`, extending core's autocomplete widget) that you select on an entity reference field's *Manage form display* tab — it simply retypes the `target_id` element to `entity_id_autocomplete`. Third, a matcher (`EntityIdAutocompleteMatcher`) wrapping core's autocomplete matcher: when the typed string loads an existing entity of the target type, it prepends a `Label (id)` suggestion — but only if the current user has the `view entity autocomplete id results` permission, the entity passes `access('view')`, and it matches any configured `target_bundles`. A decorator (`EntityIdAutocompleteMatcherDecorator`, decoration priority 60) can extend this to **every** core `entity_autocomplete` field site-wide when the `autocomplete_id_global` config flag is on (settings form at `/admin/config/content/autocomplete-id`, permission `administer entity autocomplete id`); the global path additionally requires the same view permission. The module's autocomplete controller re-validates the hashed `selection_settings_key` (HMAC with the site hash salt, `hash_equals`) exactly like core before returning matches, so opening the route is not an access bypass. No database tables, no Drush, no dependencies beyond core.

---

- Let content editors reference an entity by pasting its node/term/user ID into an autocomplete field.
- Add an "Autocomplete match ID" widget to an entity reference field via Manage form display.
- Disambiguate entities that share the same label by selecting the exact ID.
- Turn on ID matching globally for all core entity_autocomplete fields with one config toggle.
- Restrict who sees ID-based results using the `view entity autocomplete id results` permission.
- Use the `entity_id_autocomplete` render element in a custom form to accept either a label or an ID.
- Reference a specific revision-less entity when editors know the ID but not the exact title.
- Speed up data entry for power users migrating content who work from spreadsheets of IDs.
- Keep core's label-based matches while adding an ID match at the top of the suggestion list.
- Honor `target_bundles` selection settings so only allowed bundles match by ID.
- Enforce per-entity `view` access on ID matches so users can't reference entities they can't see.
- Limit the ID suggestion to respect the field's `match_limit` (drops the last label match if the cap is hit).
- Support tags (multi-value) autocomplete fields as well as single-value ones.
- Provide auto-create behavior identical to core when the selection handler supports it.
- Let an editor type `123` and get `Article title (123)` inserted into the field.
- Scope ID matching to specific roles instead of exposing it to everyone.
- Replace a custom "reference by ID" hack with a maintained, core-compatible widget.
- Match by ID in views exposed-filter or custom admin autocomplete fields (via the form element).
- Validate a manually typed ID against the selection handler and surface a form error if it doesn't exist.
- Keep the change config-exportable (single boolean `autocomplete_id_global` + widget settings on the form display).
