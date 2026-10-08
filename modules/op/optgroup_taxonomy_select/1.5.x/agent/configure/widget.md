<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — widget & selection handler

No admin page and no config object. You configure it entirely on the entity's form display.

## Enable the widget
1. On a content type (or any bundle), go to *Manage form display*
   (`/admin/structure/types/manage/<bundle>/form-display`).
2. For a taxonomy-term **entity_reference** field, set the widget to **Optgroup Term Select**.
3. Save. The field now renders as a `<select>` with `<optgroup>` headings.

Stored in the `entity_form_display` config as the field component `type: optgroup_term_select`.
The widget has no per-instance settings form (`multiple` is derived from field cardinality; a `- None -`
empty option is added for non-required fields).

## Hierarchy → optgroup mapping
`OptgroupTermSelectWidget::formElement()` calls `loadTree()` on each of the field's `target_bundles`
(vocabularies). Terms at `depth == 0` become the `<optgroup>` label; terms at deeper depths become the
selectable `<option>`s under the most recent depth-0 parent. Only two visual levels are produced.

## Optional: single-vocabulary selection handler
The module also registers an `EntityReferenceSelection` plugin `optgroup_taxonomy_select`
(`OptGroupEntityReferenceSelection`, extends core `TermSelection`). Selected in the field storage/instance
*Reference type* settings, it:
- converts the "target bundles" checkboxes to **radios** (one vocabulary only),
- builds grouped options keyed by vocabulary → parent label → term id, dash-indented by depth,
- hides unpublished terms from users without `administer taxonomy`,
- escapes labels with `Html::escape()` and honors translation context.
