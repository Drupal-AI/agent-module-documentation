# jQuery MiniColors — manual setup guide

**jQuery MiniColors** (`jquery_minicolors`) adds a color‑picker field widget that
turns an ordinary plain‑text field into a friendly swatch / hex / RGB color picker
on entity edit forms. Instead of asking an editor to type `#ff0000` by hand, you
give them a visual picker — and the chosen value is still stored as a plain string
you can drop straight into inline styles or design tokens.

The module provides a single field widget, `jquery_minicolors_widget`, that works on
**Text (plain)** (`string`) fields. You select it on a field's **Manage form
display** page. There's no dedicated field type — the color is saved as a normal
string like `#ff0000` — so it's easy to add to existing string fields on content
types, users, taxonomy terms, paragraphs, or media.

The widget has a rich per‑field settings form: the control style (hue slider,
brightness, saturation, or a color wheel), the value format (hex or RGB), an
optional opacity/alpha slider, preset swatches, the picker's position and theme,
inline vs. dropdown display, animation timing, letter case for hex values, and
accepted keywords such as `transparent`. Because the settings live on the widget,
they're exported and deployed with your form‑display config.

**One important requirement:** the picker relies on the external **jQuery
MiniColors** JavaScript library (v2.2.4), which you must download and place at
`/libraries/jquery-minicolors/` — see [Installation](installation/index.md). Without
it the field still stores and edits a plain string, but the fancy picker won't
appear.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including every widget
setting and its default — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the external JavaScript library, and enable it.

## Where it lives in the admin menu

There's no central settings page. You use the module entirely from a bundle's
**Manage form display** page (e.g.
`/admin/structure/types/manage/article/form-display`), where you assign the widget
to a string field. It adds no permissions and no Drush commands.

## How to use it

1. Add or pick a **Text (plain)** (`string`) field on your content type (or other
   entity) — this is the field that will hold the color value.
2. Go to that bundle's **Manage form display** page.
3. In the field's **Widget** column, choose **jQuery MiniColors**.
4. Click the widget's **gear / cog** icon to open its settings and tune the picker:

   - **Control** — `hue` (default), `brightness`, `saturation`, or `wheel`.
   - **Format** — `hex` (default) or `rgb`.
   - **Opacity** — turn on to add an alpha/opacity slider.
   - **Swatches** — up to seven preset colors, entered pipe‑separated, shown as
     clickable chips.
   - **Position** — where the dropdown opens (bottom/top, left/right).
   - **Theme** — `default` or `bootstrap`.
   - **Inline** — render the picker always‑open instead of as a dropdown.
   - **Letter case** — force hex values to `lowercase` (default) or `uppercase`.
   - **Keywords** — accepted keyword values such as `transparent, inherit`.
   - **Animation speed / easing**, **show/hide speed**, **change delay** — fine
     control over the picker's timing.
   - **Size** and **Placeholder** — core text‑field options for the input itself.

5. Click **Update**, then **Save** the form display.

On the entity's edit form the field now shows the MiniColors picker, and the color
you pick is saved as a plain string (for example `#ff0000`).
