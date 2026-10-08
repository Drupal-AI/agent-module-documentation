<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Display lets an AI agent introspect UI Patterns sources, read entity view displays as an abstract SDC component mapping, and compose displays from Single Directory Components deterministically — all as MCP tools.

---

Droost Display is the SDC-first display layer of Droost, built on UI Patterns (`ui_patterns`) and `ui_patterns_field_formatters`. It exposes three MCP tools. `droost_display_sources` answers "what can feed this prop or slot?": with no arguments it maps the UI Patterns prop-type registry (string, slot, attributes, url, links, ...) with each type's default source; with a `prop_type` (and optionally an `entity_type`/`bundle`/`field` context) it returns the applicable source plugins, including the dynamic per-field derivatives (`field_property:*`, `field_formatter:*`) that only exist for a given field. `droost_display_get` reads an entity view display (Manage Display) as an abstract mapping — each visible field with its formatter, weight and label position, and for UI Patterns component formatters the unwrapped component binding (component id, variant, prop sources, slot sources) — plus the bundle's viewable and hidden fields. `droost_display_compose` is the write side: it takes an abstract mapping (each field bound to one SDC with prop/slot source mappings), validates fields, components, prop/slot names, required props and source applicability up front (all-or-nothing), then persists the `EntityViewDisplay` through the entity API so dependencies are calculated correctly; `dry_run` validates and returns the would-be config without saving. The write tool extends `DestructiveToolBase` and is gated behind `droost.settings.allow_config_write` and the CLI transport; the read tools are `readOnly`. `DisplayContextBuilder` mirrors ui_patterns_field_formatters' own context set and builds an in-memory sample entity (no tempstore write) so read/validate/dry-run paths write nothing. All tools require the mcp_server "access mcp server" permission. Local development only. NOTE: a hook_requirements check warns when Drupal Canvas is installed, because both modules take over the SDC plugin manager.

---

- Discover the full UI Patterns prop-type registry (string, slot, attributes, url, ...) with `droost_display_sources`.
- List which source plugins can feed a specific prop type before composing a display.
- Include a field's dynamic sources (`field_property:*`, `field_formatter:*`) by passing entity_type + bundle + field.
- Find the default source for a prop type so an agent picks a sensible binding.
- Read an existing entity view display as an abstract field -> component mapping with `droost_display_get`.
- See which fields on a bundle are placed, SDC-bound, or hidden.
- Inspect a bundle's viewable field definitions (type, cardinality, required) to know what is left to place.
- Compose an entity view display from SDCs deterministically with `droost_display_compose`.
- Bind each field to one SDC with explicit prop and slot source mappings.
- Validate a composition without writing anything using `dry_run: true`.
- Hide every non-listed field so the rendered output is SDC-only (`hide_others`, default true).
- Catch invalid prop/slot names, unbound required props, and inapplicable sources before any config is written.
- Get calculated config dependencies back after a successful compose.
- Let an agent turn a design intent into green Manage-Display config repeatably (same input -> same config).
- Avoid the date-only-datetime silent-empty formatter trap (the tool rejects it with a teaching error).
- Coexist with Drupal Canvas only after applying the SDC-manager coexistence patch (see README / install warning).
