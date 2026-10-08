<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plugin Reference provides a `plugin_reference` field type that stores a **plugin ID** (plus optional plugin configuration) instead of an entity ID, so content and config can point at a block, a condition, a queue worker or any other plugin type — with autocomplete, validation and per-field selection handlers, exactly like Entity Reference does for entities.

---

Entity Reference is the answer whenever content needs to point at an entity, but plugins are not entities: they are discovered from code, identified by a string ID, and have no storage of their own, so referencing one usually means storing a bare string and hoping it still exists. This module turns that into a proper field. A field's storage setting `target_type` names a plugin type whose manager service is `plugin.manager.<target_type>`; the field's `handler`/`handler_settings` choose a selection handler that decides which plugin IDs are referenceable and how they sort or filter. It ships three widgets — `plugin_reference_select` (default), `plugin_reference_autocomplete` and `plugin_reference_options_buttons` — two formatters (`plugin_reference_id`, `plugin_reference_label`), and a `plugin_autocomplete` form element backed by a permission-gated, HMAC-verified autocomplete route. When a referenced plugin implements a configuration form, the widget embeds it and stores the result in the item's `configuration` column, so the field captures both *which* plugin and *how* it is configured. It also defines its own `PluginReferenceSelection` plugin type (manager `plugin.manager.plugin_reference_selection`) so site builders can narrow selectable plugins, and a `PluginTypeHelper` service that discovers plugin managers by scanning service IDs. "Soft" is the load-bearing word: nothing guarantees the referenced plugin still exists after a module is removed, and the field renders a dangling ID as empty, so consuming code must handle a missing plugin.

---

- Let editors choose a block plugin from a field on a node.
- Store a reference to a condition plugin in content.
- Reference a queue worker or action plugin from configuration.
- Give a field an autocomplete over plugin IDs.
- Capture both a plugin and its configuration in one field.
- Narrow the selectable plugins with a selection handler.
- Reference a field formatter or field type plugin.
- Validate that a chosen plugin still exists on save.
- Build a plugin picker UI for site builders.
- Reference a custom plugin type your module defines.
- Filter selectable plugins by provider or plugin ID.
- Exclude specific plugins from a field with a negated filter.
- Group the select-list options per providing module.
- Restrict plugin-list enumeration to trusted roles via the permission.
- Write a `PluginReferenceSelection` handler to control referenceable plugins.
- Show only blocks the current user may access (block selection handler).
- Render the stored plugin's ID or human label with a formatter.
- Instantiate the referenced plugin in code via `referencedPlugin()`.
- Model a rules-style or pluggable-component configuration entity.
- Provide a typed alternative to hard-coding plugin IDs in a text field.
- Prototype plugin-driven behaviour against entities quickly.
- Let content drive which plugin runs a background action.
