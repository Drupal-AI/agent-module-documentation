# Configuration

Spain NIF, NIE and CIF Field has **no site-wide settings page**. Everything is
configured per field, on the field's **widget** settings in Manage form display.

## Configure the field widget

1. Go to **Structure → Content types → *(your type)* → Manage form display**.
2. Click the **gear icon** next to the NIF/NIE/CIF field's widget.
3. Set the widget options:

   - **Allowed identification types** — choose which of **NIF**, **NIE**, and
     **CIF** editors are permitted to enter in this field. Restrict it to only the
     types that make sense for the field (for example just **CIF** on a company
     field). At least one type must remain selected.
   - **Smart / auto-detect mode** — an optional mode that presents a single input
     and detects the identification type automatically from what the editor types,
     instead of asking them to pick the type first. Manual type selection is the
     default, kept for backward compatibility.

4. **Update** the widget, then **Save** the form display.

## What editors can type

The field is forgiving about formatting: it accepts **lowercase** input and common
visual separators such as **spaces, dots, and hyphens**, then stores the value in a
clean **canonical uppercase** form with the separators removed. Editors also get
accessible live feedback when a type is detected or a value is invalid.

## Validation everywhere

Validation runs through Drupal's Validation API, so the format-and-control-digit
check applies not only on the node form but also in entity-aware integrations that
validate the entity. The optional Webform element behaves the same way, always
auto-detecting and validating the value.

> **Note:** NIF/NIE/CIF numbers are personal / tax data. Handle and store them with
> appropriate privacy care.
