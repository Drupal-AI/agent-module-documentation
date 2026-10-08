<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete Entity ID — agent index

Extends core entity autocomplete so users can match/pick a referenced entity by its numeric ID.
Ships a form element, an entity-reference field widget, a matcher, and a global-mode decorator.
No dependencies beyond core; no Drush; provides permissions + config schema.

- **Enable per-field or globally; settings form, config keys, storage** →
  [configure/settings.md](configure/settings.md)
- **The `entity_id_autocomplete` element and `entity_reference_autocomplete_id` widget for custom code** →
  [api/element-and-widget.md](api/element-and-widget.md)
- **The two permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config: `autocomplete_id.settings:autocomplete_id_global` (bool, default `false`). Settings form at
  `/admin/config/content/autocomplete-id` (route `autocomplete_id.settings`, perm
  `administer entity autocomplete id`).
- Widget id `entity_reference_autocomplete_id` (field type `entity_reference`) — pick on Manage form
  display; it just retypes `target_id` to the `entity_id_autocomplete` element.
- ID suggestion appears only when: user has `view entity autocomplete id results`, entity passes
  `access('view')`, and bundle is in `target_bundles` (if set). Global mode additionally requires
  `autocomplete_id_global` = true (checked by `EntityIdAutocompleteMatcherDecorator`, decorates
  `entity.autocomplete_matcher`, priority 60).
- Autocomplete route `autocomplete_id.entity_id_autocomplete` uses `_access: TRUE` but re-checks the
  HMAC-hashed `selection_settings_key` with `hash_equals` (same guard as core) — not an access bypass.
