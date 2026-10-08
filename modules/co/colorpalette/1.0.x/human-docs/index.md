# Color Palette — manual setup guide

**Color Palette** (`colorpalette`) gives content editors a curated color picker.
Instead of a free‑form "any hex value you like" input, editors choose from a set
of **pre‑approved colors** you manage as taxonomy terms — so a site stays on
brand and nobody invents a slightly‑wrong shade of your primary color.

The colors live in a vocabulary the module creates for you. Each color is a
taxonomy term with a hexcode, and a second vocabulary of **filter tags** (labels
like *Light*, *Dark*, *Primary*, *Accent*) lets you group them. On any field you
can then attach the **Color Palette** widget: editors see a button next to the
field that opens a modal swatch picker, and clicking a swatch writes the chosen
color back into the field. You can limit which colors a given field offers by
choosing filter tags in the widget settings — for instance, only show the
*Light* palette on a "background color" field.

The widget works on **entity reference**, **plain text** (`string`), and
**formatted/long text** (`text`) fields, on any entity type (nodes, users,
taxonomy, media, paragraphs). For a text field the picked hexcode is stored as a
string; for an entity‑reference field the choice is stored as a reference to the
color term. Privileged users (those with the **Administer palette** permission)
also get a "New Color" action inside the picker to add an approved color on the
fly, and the Colors vocabulary can be re‑sorted into a natural color order.

The module needs only Drupal core. It has **no global settings page** — you
configure it per field on the **Manage form display** tab, and you manage the
colors themselves in the Taxonomy UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (which creates the two vocabularies).

## Where it lives in the admin menu

Color Palette has no dedicated settings page. You work with it in three places:

- **Structure → Taxonomy → Colors** (`colorpalette_colors`) — add, edit, and
  unpublish the approved colors, each with its hexcode.
- **Structure → Taxonomy → Filter Tags** (`colorpalette_filter_tags`) — manage
  the grouping labels (Light, Dark, …).
- The **Manage form display** tab of whatever field you want to use the picker on
  — this is where you switch the field's widget to **Color Palette**.

## How to use it

1. **Add some colors.** Go to **Structure → Taxonomy → Colors**, add a term for
   each approved color, and set its hexcode (a native color input is provided).
   Optionally create **Filter Tags** and assign them to colors so they can be
   filtered later. Only **published** colors appear in the picker, and hexcodes
   must be unique.
2. **Attach the widget to a field.** On the entity you want to edit, open
   **Manage form display** and, for a text or entity‑reference field, choose the
   **Color Palette** widget in the *Widget* column.
3. **(Optional) Restrict the colors.** Click the widget's gear icon and set one
   or more **filter tags** — the picker for that field will then only show colors
   carrying those tags. Leave it empty to offer the whole palette. Click
   **Update**, then **Save**.
4. **Edit content.** On the entity form, editors now see a launch button next to
   the field. Clicking it opens the palette modal (with a search box); clicking a
   swatch fills the field, and a **Clear** button empties it.
5. **(Optional) Let editors add colors.** Grant the **Administer palette**
   permission to trusted roles at **People → Permissions**. Those users get a
   **New Color** action inside the picker to create a color — or reuse and
   publish an existing one — without leaving the content form.

Tip: on the Colors vocabulary overview there is a **Reset colorwise** action that
re‑sorts all color terms into a natural (HSV) order, which makes the palette
easier to scan.
