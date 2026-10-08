Field View Mode (fvm) lets editors pick, per individual entity, which view mode that entity is rendered in, by adding a locked `view_mode_selection` entity-reference field (to `entity_view_mode`) on the bundles you choose from a central settings form.

---

The module's settings form (`/admin/structure/display-modes/view/fvm`, route `fvm.settings_form`,
permission `administer display modes`) lists every content entity bundle that has more than the
`default` view mode. Checking a bundle creates a locked `entity_reference` field named
`view_mode_selection` (target type `entity_view_mode`) on that bundle and adds it to the default form
display; unchecking it deletes the field (and its data, after a `field_purge_batch`) only when no rows
use it. Per bundle you may also limit which view modes appear in the dropdown; if none are selected all
enabled view modes are offered. Selection is constrained by a custom EntityReferenceSelection plugin
(`field_view_mode`) that filters the referenceable `entity_view_mode` entities to the bundle's allowed
list, and the `fvm_options_select` widget (extends core `OptionsSelectWidget`) renders it as a select
list with a configurable "none/Default" label. At render time `hook_entity_view_mode_alter()` reads the
chosen value and switches the entity's view mode accordingly. For `block_content` used with Layout
Builder, the module hides one of the two competing "view mode" fields (its own by default, or Layout
Builder's if you tick "Hide Layout builder view mode field"). There is no permission of its own, no
config schema, and no Drush commands. Note the README warning: to stop using it on a populated bundle,
hide the field via the form display rather than unchecking the bundle, to avoid data loss.

---

- Let editors choose the view mode for a specific node (e.g. "Full", "Teaser", "Featured") at edit time.
- Render one article in a "Featured" layout while the rest use the default, without code.
- Add per-entity view-mode selection to a content type from a single central form.
- Restrict the selectable view modes offered on a bundle to a curated subset.
- Provide a friendly "Default" empty option (or rename/hide it) in the selection widget.
- Switch a media entity's display per item (e.g. large vs. thumbnail rendering).
- Give taxonomy terms a per-term view mode where multiple term displays exist.
- Let a block content item pick its own view mode outside of Layout Builder.
- Avoid Layout Builder just to vary a single entity's rendering.
- Hide FVM's field automatically on Layout Builder block forms to prevent conflicts.
- Alternatively hide Layout Builder's own view-mode field and standardize on FVM's.
- Bulk-enable per-entity view modes across many bundles from one settings screen.
- Skip bundles that only have the default view mode (they are auto-excluded from the form).
- Create the reference field automatically (no manual Field UI setup) when enabling a bundle.
- Remove the field cleanly for a bundle that has no data by unchecking it.
- Keep the selection field locked so it isn't accidentally reconfigured in Field UI.
- Drive contextual display variations (promoted, sidebar, print) chosen by content authors.
- Let a comment or custom entity type expose per-entity view-mode switching.
- Standardize editorial control of display without granting broad Field UI access.
- Present a select list rather than an autocomplete for the view-mode choice (via `fvm_options_select`).
