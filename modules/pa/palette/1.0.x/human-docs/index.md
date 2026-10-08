# Palette — manual setup guide

**Palette** (`palette`) gives your editorial team a curated, reusable set of
colors to pick from, instead of a free-form hex box where anyone can type any
value. It builds on the **Color Field** module: where Color Field alone lets an
editor enter any hex code — which, over time, scatters a dozen slightly-different
shades of "brand blue" across your content — Palette lets an administrator define
a managed set of named colors and gives editors a visual swatch picker to choose
from.

Each managed color is stored as a small **`palette_color` content entity** with a
label (for example "Corporate Blue") and a hex value. Administrators manage them
at **Structure → Palette colors** (`/admin/structure/palette-colors`), gated by
the **Administer palette** permission. Colors can be enabled or disabled (retire a
color without deleting it), and because they are entities they integrate with
Views for listing and filtering.

On the editing side, any Color Field can be switched to the **Palette** widget on
its form display. Editors then click to pick a swatch from a clean visual modal —
no hex codes required — and can even add a new palette color inline through the
bundled Entity Browser widget. Palette requires both **Color Field** and **Entity
Browser** and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Palette and its Color Field
   and Entity Browser dependencies with Composer, and enable it.

There is **no module-wide settings form**. Setup is two steps done through the
normal admin UI: define your colors, then switch a field's widget — both
described in "How to use it" below.

## Where it lives in the admin menu

Palette adds a color collection at **Structure → Palette colors**
(`/admin/structure/palette-colors`) for managing the reusable colors. The widget
itself is chosen per field under **Manage form display**.

## How to use it

1. **Define your palette.** Go to **Structure → Palette colors**
   (`/admin/structure/palette-colors`) and click **Add palette color**. Give each
   color a name and a hex value. Add as many as your brand needs. You can edit or
   delete them later, or disable one to retire it without removing it.
2. **Switch a field to the Palette widget.** On any field of type **Color Field**
   (`color_field_type`), open the bundle's **Manage form display** (for example
   **Structure → Content types → *(type)* → Manage form display**) and set that
   field's widget to **Palette**. Save.
3. **Edit content.** Editors now see a **Select color** button on that field.
   Clicking it opens the swatch modal; picking a swatch fills the field
   automatically. If they need a color that isn't there yet, the inline Entity
   Browser widget lets them add a new palette color without leaving the edit form.

> **Tip:** Managing palette colors requires the **Administer palette** permission —
> grant it at **People → Permissions** to the roles that should curate your brand
> colors.
