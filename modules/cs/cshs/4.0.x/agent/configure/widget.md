# CSHS field widget

Widget `@FieldWidget(id = "cshs")` for **entity_reference** fields that target a taxonomy
vocabulary. Set it at **Manage form display** (`/admin/structure/types/manage/<bundle>/form-display`)
by choosing "Client-side hierarchical select" for the term field.

## Settings
Configured via the widget's gear icon; stored per display (schema
`config/schema/cshs.schema.yml`, type `cshs`):

| Setting | Key | Effect |
|---|---|---|
| Save lineage | `save_lineage` (bool) | Store the whole ancestor chain of the picked term, not only the leaf. |
| Force deepest level | `force_deepest` (bool) | Editor must select a leaf term; non-leaf choices are rejected. |
| Parent | `parent` (string) | Restrict the tree to descendants of this parent term (empty = whole vocabulary). |
| Level labels | `labels` (label) | Custom label per hierarchy level (e.g. Region / Country / City). |

Behavior: the widget renders as a `cshs` form element (`src/Element/CshsElement.php`, extends
core `Select`); child dropdowns appear client-side as the user picks each level, so there is
no per-level AJAX. Applicability to a field is decided by `src/IsApplicable.php` (must be an
entity_reference to a taxonomy vocabulary). Options/label wiring lives in
`src/CshsOptionsFromHelper.php`.

For display of the stored value, see [formatters.md](formatters.md).
