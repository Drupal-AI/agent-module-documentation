# Configuration

Setting up Component Fields is a three-step journey across three pages, all under
`/admin/config/component-fields/settings`. You first choose which bundles can use
the feature, then define the field groups (one final field plus its two
component fields) and pick a compiler for each, and finally — if you want — turn
on per-entity overrides. You will need the module's administration permission
(granted at **People → Permissions**).

## Step 1 — Enable the bundles

Go to **`/admin/config/component-fields/settings`**. You will see a list of all
content entity types and their bundles. Tick the bundles you want to use
Component Fields on, then **save the form**. This simply opts those bundles in;
nothing is calculated yet.

## Step 2 — Define the field groups

Go to **`/admin/config/component-fields/settings/fields`**. Each enabled bundle
gets its own fieldset here, where you add **groups**. A group is one final field
plus the two component fields that feed it:

1. **The bundle must have at least three fields of the same type** that are not
   already used in another group — otherwise there is nothing to build a group
   from.
2. **Select the final field** for the group from the first dropdown.
3. Two more dropdowns then appear — **select the two component fields**, one in
   each.
4. A fourth dropdown appears with the available **compilers**. Choose the default
   compiler for this field on this bundle:
   - **Component 1** — the final value is the first component's value.
   - **Component 2** — the final value is the second component's value.
   - **Component 1 with fallback 2** — the first component if it is non-empty,
     otherwise the second.
   - **Component 2 with fallback 1** — the second component if it is non-empty,
     otherwise the first.
   - **Merge** — the union of both components' values (multivalue fields only).
   - **Empty value** — the final value is set explicitly empty.

Save the form. From now on, whenever an entity of that bundle is saved, the final
field is recalculated from its two component fields using the chosen compiler.

## Step 3 — (Optional) enable per-entity overrides

Go to **`/admin/config/component-fields/settings/overrides`** to allow editors to
override the compiler on a per-entity basis, rather than always using the default
you set in Step 2.

To enable overrides for a bundle, that bundle needs **at least one `string_long`
field** available — the overrides are stored there as a stringified JSON object.
Once enabled, the module provides a widget on the override field that presents the
list of compilers as radio buttons for each compilable field, so an editor can
choose, per entity, how each final field should be built.

## A note on access and safety

Component Fields does **not** add any access control of its own. Because final
fields are calculated on a pre-save hook, they are meant to be read-only for
users — do not give anyone edit access to a final field directly. Control who can
see or edit the component fields (and the final field) entirely through Drupal's
normal field settings and permissions, configured separately from this module.
