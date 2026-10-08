<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Field Condition provides a `node_field` Condition plugin that returns TRUE/FALSE based on whether a node in context has a chosen field whose value is NULL, exactly matches, or contains a given string — usable anywhere Drupal evaluates conditions (most commonly block visibility).

---

The module ships a single Condition plugin, `node_field`, that requires a `node` context (`@ContextDefinition("entity:node")`). Its configuration form lets you pick a node type (or "Any bundle"), then AJAX-loads that bundle's fields into a second select, choose a **Value Source** (`null` = "Is NULL", `specified` = exact `===` match, `contains` = regex `preg_match`), and enter a value to compare. At evaluation time it reads the field off the contextual node: for multi-value/structured fields it iterates each delta and compares `target_id` (references), `uri` (links), or `value`, returning TRUE on the first match; for scalars it compares directly. An empty field selection evaluates TRUE (unless negated). Because it is a standard `ConditionPluginBase`, it plugs into block visibility, and any other consumer of the condition/context system, and its settings are stored inside that host's config (e.g. a block's `visibility.node_field`). It has no admin settings page of its own (`configure: null`), no permissions, and no Drush; it only defines the plugin and its config schema (`condition.plugin.node_field`).

---

- Show or hide a block depending on the value of a field on the current node.
- Display a block only when a node's field is empty (Value Source = "Is NULL").
- Display a block only when a field exactly equals a given value (Value Source = "Specified").
- Display a block when a field's value contains a substring/pattern (Value Source = "Contains").
- Target the condition to a specific content type, or to "Any bundle" across all node types.
- Hide a promo block on articles whose "featured" boolean field is unset.
- Show a call-to-action block only on nodes whose category term reference matches a target id.
- Show a block when a link field's URI contains a particular domain.
- Gate a block on whether a node's body/summary contains a keyword.
- Combine with the block "Negate the condition" toggle to invert any of the above.
- Reuse the condition on multiple blocks with different field/value pairs.
- Show contextual help blocks only when a required field is still NULL (prompting editors).
- Drive layout differences based on a node field without writing a custom condition plugin.
- Check a reference field's `target_id` to show related-content blocks conditionally.
- Match against a specific list/select field option value to segment content.
- Show region-specific content when a node's "region" field contains a value.
- Provide editors a no-code way to make block placement field-value aware.
- Evaluate the same condition programmatically via the condition plugin manager on a node.
- Use "Any bundle" plus a common field (e.g. `title`) to match across content types.
- Show a banner only on nodes whose status/workflow field equals a given state string.
- Restrict a block to nodes where a text field contains an internal campaign code.
- Build simple personalization rules keyed off node field content.
