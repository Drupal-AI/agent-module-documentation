<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Limits — agent index

Lets you set a **min and max count per paragraph type** on a Paragraphs field. Enforced by hiding
"Add" options at the max and by a validation constraint on submit.

- **Turn it on for a field, set limits, and where they're stored** →
  [configure/limits.md](configure/limits.md)

Key facts:
- Depends on `paragraphs`. No configure route (`configure: null`), no permissions, no Drush.
- You enable it by setting the paragraph field's **reference method (handler)** to
  `paragraphs_limits` (an `EntityReferenceSelection` plugin extending Paragraphs'
  `ParagraphSelection`).
- Limits live in the field config: `field.field.<entity>.<bundle>.<field>` →
  `settings.handler_settings.target_bundles_drag_drop.<paragraph_type>.lower_limit` /
  `.upper_limit` (integers; **`0` = no limit**).
- Enforcement: `hook_entity_bundle_field_info_alter()` adds the `ParagraphsLimits` validation
  constraint (min/max messages) to fields using the handler; a widget-complete form alter removes a
  type from "Add more" once its upper limit is reached.
- Provides config schema (`entity_reference_selection.paragraphs_limits`). Defines no plugin types
  (it implements a selection plugin + a constraint). Uninstall reverts fields to `default:paragraph`.
