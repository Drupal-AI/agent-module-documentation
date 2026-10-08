# Configuration

Table Colors is configured **per text format**, not on a global settings page.
The options live in the plugin's settings on each CKEditor 5 text format, so
different formats can offer different palettes.

## Open the settings

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
3. Click **Configure** on the format you want to style (for example *Full HTML*).
4. In the CKEditor 5 configuration, open the **Table Colors** plugin settings.

## The settings, field by field

- **Include default CKEditor 5 colours** — choose whether CKEditor 5's built-in
  colour set appears alongside your custom palette, or whether editors see only
  your colours. Turn it off when you want to restrict editors to an approved
  brand palette.
- **Custom colours** — define your own colour palette. Each entry is a colour
  value, and you can add a **descriptive label** (for example "Brand blue" or
  "Warning red") so editors recognise what each swatch is for. These apply to
  both table and cell backgrounds and borders.
- **Colour picker** — optionally enable a picker so editors can choose any custom
  colour beyond the predefined palette. Leave it off to keep editors within the
  approved set.
- **Grid columns** — set how many columns the colour selection grid uses, which
  controls how the swatches are laid out in the dropdown.
- **Document colours** — optionally show recently used colours from the current
  document, so editors can quickly reuse a colour they have already applied.

The module distinguishes **background colours** from **border colours** and lets
you configure them separately, so you can offer one set of fills and another set
of outlines if you wish.

## Save

Save the plugin settings and then **Save configuration** on the text format.
Reload a content edit form for that format and the colours will be available in
the table and table-cell property dropdowns.

> **Tip:** Colours are written as inline style on the table markup. If a colour
> you apply does not appear on the rendered page, check that the text format's
> filters (especially *Limit allowed HTML tags*) permit the relevant `style`
> attributes so the styling is not stripped on save.
