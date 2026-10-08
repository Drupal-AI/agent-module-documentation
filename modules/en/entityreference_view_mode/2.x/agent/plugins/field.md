<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference View Mode — field plugins

A single compound field carrying an entity reference plus a view mode.

## Field type
`EntityReferenceViewModeFieldType` (`src/Plugin/Field/FieldType/`) stores the reference (target id / entity) together with a selected `view_mode` string. Configure the referenceable target entity type in the field's storage/instance settings.

## Widget
`EntityReferenceViewModeFieldWidget` (+ `EntityReferenceViewModeFieldWidgetTrait`) renders, per item, the entity selection control and a view-mode `select`. Set it as the field's form-display widget.

## Formatter
`EntityReferenceViewModeFieldFormatter` loads the referenced entity and renders it via the chosen view mode using the entity view builder. Set it as the field's display formatter. Because rendering goes through the view builder, the referenced entity's own access and view-mode display settings apply.

## Typical use
Reference an entity once but choose its presentation (teaser/full/custom) per item and per placement, instead of creating separate fields or overriding display config.
