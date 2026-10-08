# Configuration

Spain NIF, NIE and CIF Field has **no site-wide settings page**. Everything is
configured per field, on the `nif_nie_cif_default` **widget** in Manage form
display. The choices you make are saved into the entity form display config with the
rest of the field's settings, so they travel with a config export.

## Configure the field widget

1. Go to **Structure → Content types → *(your type)* → Manage form display**.
2. Click the **gear icon** next to the NIF/NIE/CIF field's widget.
3. Set the two widget settings:

   - **Allowed identification types** (`allowed_types`) — tick which of **NIF**,
     **NIE**, and **CIF** editors may enter in this field. **At least one is
     required** — saving with none selected produces the error "Select at least one
     identification type." By default all three are allowed.
   - **Auto-detect the identification type** (`auto_detect`) — off by default. When
     **off**, the widget shows a **type selector** plus a number field. When **on**,
     it shows a **single smart input**: the type selector is hidden and the type is
     inferred from the number entered.

4. **Update** the widget, then **Save** the form display.

## How the settings behave

- With **auto-detect on**, an entered number is normalized and identified; if it
  validates but its detected type is not in your allowed list, it is rejected with
  "@type identification numbers are not allowed in this field."
- With **manual mode**, if a stored value's type is no longer among the allowed
  types, the selector will not pre-select it — the editor must choose an allowed
  type and enter a valid matching number before the entity can be saved. (In other
  words, tightening the allowed types can force editors to replace now-disallowed
  legacy values.)
- If an exported config somehow has an empty or invalid `allowed_types`, the widget
  safely falls back to allowing all three types.
- The widget's settings summary reports the allowed types and whether the type is
  auto-detected or selected.

## Input normalization

Whatever mode you use, editors can type lowercase letters and common separators.
The value is **uppercased and stripped of spaces, dots, and hyphens**, so
`12.345.678-Z` or `B 99286320` are accepted and stored in canonical form.

## Validation runs everywhere

The `NifNieCif` constraint validates the field through Drupal's validation API, so
the same format-and-checksum check applies on the node form, over JSON:API, and in
any other entity validation — not only through the widget.

## The Webform element

The optional Webform element (`nif_nie_cif`, from the `field_nif_nie_cif_webform`
submodule) has **no allowed-types or auto-detect settings**: it always
auto-detects and accepts any valid NIF, NIE, or CIF, normalizing the value before
it is stored.

> **Note:** NIF/NIE/CIF numbers are personal / tax data. Handle and store them with
> appropriate privacy care.
