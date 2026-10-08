# Configuration

Everything you configure lives at **Configuration → Content authoring → Layout
builder styles** (`/admin/config/content/layout_builder_style`). You create two
kinds of thing here — **styles** and **style groups** — and both are exportable
configuration, so they travel between environments with the rest of your config.

Managing them requires the **Manage layout builder styles** permission.

## Styles

A style is a named bundle of CSS classes that an editor can apply to a block or a
section. Use the *Add style* action link on the collection page. Each style has:

- **Label** — the human‑readable name editors see in the selector (for example
  "Muted background" or "Full width").
- **Machine name** — the internal id, generated from the label.
- **CSS classes** — the class or classes applied when this style is selected. You
  can list several, separated by spaces or new lines; all of them get attached to
  the markup.
- **Type** — whether this style targets a **block** or a **section**. This decides
  where the style shows up in the Layout Builder UI.
- **Group** — optionally, the style group this style belongs to (see below). Leave
  it ungrouped to present the style as a standalone option.
- **Block restrictions** — optionally limit the style so it only appears for
  specific block plugins. Leave empty to allow it on all blocks.
- **Layout restrictions** — optionally limit the style so it only appears for
  specific layout plugins. Leave empty to allow it on all layouts.
- **Weight** — controls the order styles appear in relative to each other.

## Style groups

A group bundles related styles into a single, curated selector — for instance one
"Background color" dropdown instead of a scatter of independent checkboxes. Use
the *Add style group* action link. Each group has:

- **Label** and **machine name** — as above.
- **Allow multiple styles to be selected (multi‑select)** — when on, an editor can
  apply more than one style from the group at once; when off, it is a single
  choice.
- **Form type** — how the group is presented to editors: a **select** dropdown, or
  **radios / checkboxes**. (Checkboxes go with multi‑select; radios with a single
  choice.)
- **Required** — whether the editor *must* pick a style from this group before
  they can save the block or section.
- **Weight** — controls the order groups appear in relative to each other.

## Putting it together

A common setup is to create a group like "Spacing" (single‑select dropdown, not
required), then create several styles ("None", "Small", "Large") assigned to that
group, each mapping to your theme's spacing utility classes. Editors then see one
tidy "Spacing" dropdown when they configure a section — and the right classes land
in the markup, ready for your theme to style.
