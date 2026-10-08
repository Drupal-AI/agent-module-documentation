# Configuration

This module has a small global settings form, but the configuration that matters
is done **per field instance**, where you decide exactly how a color field
behaves on a given content type.

## The module settings form

A settings form exists at route `dsfr4drupal_colors.settings`, reachable from the
module's **Configure** link on the **Extend** page (`/admin/modules`). Settings
here are stored through Drupal's configuration system and export with the rest of
your site config. Because the palette is imported automatically from the official
DSFR sources on cron, there is normally nothing you must set here for day‑to‑day
use.

## Per‑field configuration (the main task)

Add a **DSFR color** field to a content type
(**Structure → Content types → *(type)* → Manage fields → Add field**), then
configure that field instance. Per field you can:

- **Limit the selectable colors** — restrict editors to a chosen subset of the
  DSFR palette rather than the whole set.
- **Choose the color code integration method** — how the selected color is
  emitted when the field is rendered.
- **Wrap the selected colors into custom CSS** — surround the chosen color with
  your own CSS so it is applied where you need it.
- **Enable contrast‑ratio validation** — validate the chosen color's contrast
  against either a fixed color (a hexadecimal code or a DSFR color name) or
  against **another DSFR color field**, helping keep combinations accessible.

Because the module stores the **DSFR color variable name** (not a raw hex value),
a field configured this way automatically renders correctly in both light and
dark modes.

## Save

Save the field settings. Editors will then see the constrained DSFR color picker
when creating or editing content of that type.
