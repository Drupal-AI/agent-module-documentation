# Configuration

Content Groups has no central settings page. Everything is configured per text
format: you add the widget buttons you want to a format's CKEditor 5 toolbar, then
set that format's default behavior for each widget. Editors can later override the
exposed settings on individual widgets from a properties panel inside the editor.

## Add the widget buttons to a text format

1. Log in as a user who can administer filters (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses
   CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the widgets you want — any of
   **Accordion**, **Horizontal tabs**, and **Vertical tabs** — from the *Available
   buttons* tray into the *Active toolbar*. Because each widget is an independent
   plugin, enable only the ones you need.
4. Make sure the format's **Allowed HTML tags** permit the markup the widgets
   produce, so the filters do not strip it on render.
5. Click **Save configuration**.

## Set the per‑format defaults

When a widget's button is on the toolbar, its settings appear under the CKEditor 5
plugin settings for that format. These become the defaults for every widget an
editor inserts in that format. You choose which of them editors may override per
instance; a setting you do not expose stays locked to the format default, and the
in‑editor Properties button hides itself when nothing is editable.

### Accordion options

- **Number of items** — how many accordion items a new widget starts with.
- **Initial state** — whether items start *all collapsed*, with the *first item
  open*, or *all expanded*.
- **Allow multiple items open at once** — whether opening one item leaves others
  open, or closes them.
- **Collapsible active item** — whether the currently open item can be clicked
  closed.
- **Open/close animation** — turn the expand/collapse animation on or off.
- **Arrow indicator position** — show the arrow on the *left*, on the *right*, or
  *none*.

### Tabs options (horizontal and vertical)

- **Default active tab** — which tab is selected when the content loads.
- **Keyboard navigation** — allow moving between tabs with the arrow keys.
- **Tab alignment** — how the tab strip is aligned.
- **Minimum panel height** — a floor for the panel area so short tabs do not make
  the layout jump.

Vertical tabs additionally support:

- **Minimum tab width** — a floor for the width of the vertical tab strip.
- **Minimum tab count** — the fewest tabs the widget will keep.

Click **Save configuration** when you are done.

## What editors do

With a button on the toolbar, an editor places the cursor and clicks it to insert
the widget. An inline contextual toolbar (a balloon) appears with buttons to add
or remove items/tabs, reorder them (move up/down or left/right), and expand or
collapse accordion items — all without losing existing content. Where you exposed
settings for override, a **Properties** button opens a panel to adjust that
instance.

## Structured data (schema submodule)

If you enabled **CKEditor Content Groups Schema**, each widget gains a
per‑instance toggle to emit JSON‑LD structured data — FAQPage for accordions,
ItemList for tabs — which helps search engines understand the content. Leave it off
where structured data is not appropriate for the content.
