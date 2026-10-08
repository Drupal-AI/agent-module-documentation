# Font Awesome Iconpicker — manual setup guide

**Font Awesome Iconpicker** (`fontawesome_iconpicker`) gives content editors a
searchable **icon‑picker** for choosing a Font Awesome icon, instead of making them type
a CSS class like `fa-house` by hand. You add it to an ordinary text field, and editors
get a popup grid of Font Awesome icons (Solid, Regular, and Brands) they can search and
click. A matching display formatter then renders the chosen icon on the page.

It comes as two pieces that attach to any core **Text (plain)** or **Text (formatted)**
field: a **field widget** ("Font Awesome Icon Picker") that you set on *Manage form
display*, and a **field formatter** (also "Font Awesome Icon Picker") that you set on
*Manage display*. The widget stores the icon's class string in the field; the formatter
renders it as an accessible `<i class="fa …" aria-hidden="true">` element at a size you
choose. Typical uses: an icon for a menu item, a call‑to‑action button, a card or tile, a
taxonomy category, or a paragraph component.

There is **no admin settings page, no permissions, and no Drush** — everything is
configured per field on the display forms. The module depends on the contributed **Font
Awesome** module (which supplies the actual icon CSS/webfont) and on the external
`d34dman/vanilla-icon-picker` JavaScript library, installed under `/libraries`. It works
across Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the Font
   Awesome module and the icon‑picker library) and enable the module.

## Where it lives in the admin menu

There is no dedicated admin page. You set the widget under **Structure → (your content
type) → Manage form display** and the formatter under **Manage display**, on the row for
your icon field.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Add a **Text (plain)** field to a bundle (Text plain is recommended for storing the
   icon class).
3. On **Manage form display**, set that field's **Widget** to **Font Awesome Icon
   Picker**. Its settings (via the cog) are:
   - **Type** (required) — *Default* (the plain picker) or *As a bootstrap component*
     (loads the Bootstrap 5 theme, for sites already using Bootstrap).
   - **Size** — the width (HTML `size`) of the text input (default 60).
   - **Placeholder** — placeholder text for the field.
4. On **Manage display**, set the field's **Formatter** to **Font Awesome Icon Picker**
   and choose an icon **size** from `fa-1x` to `fa-5x`.
5. Save.

Editors of that content type now get a searchable icon popup, and the selected icon
renders at the chosen size. Because the widget and formatter are stored in the
form‑display and view‑display config, you can export and deploy the setup like any other
configuration, and reuse the same widget across multiple content types for a consistent
icon‑selection experience.
