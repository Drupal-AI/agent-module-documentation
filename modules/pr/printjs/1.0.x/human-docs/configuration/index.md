# Configuration

Printjs has one main setting: **which element to print**, identified by its CSS
**id**.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to the Printjs settings form at `/admin/config/…/printjs` (registered as
   `printjs.settings`).

## The "id to print" setting

- **Element id** — the HTML `id` of the region Print.js should send to the printer.
  The default is **`print`**, meaning the module prints the content inside
  `<div id="print"> … </div>`.

Set this to match the id you wrap your printable content in. When a visitor clicks
the Printjs button, only the content inside that element — plus the page's CSS — is
sent to the browser's print dialog, leaving the surrounding navigation, sidebars,
and footer out of the printout.

## Save

Click **Save configuration**. Then make sure the content you want printable is
actually wrapped in an element with that id.

## Tips

- **Styling.** Print.js does not automatically carry every stylesheet, so if the
  printed output looks unstyled, ensure the relevant CSS is available to the print
  view. This is the most common issue people hit.
- **What gets printed is what's in the DOM.** Content that is lazy‑loaded, hidden in
  an unopened tab, or behind a "show more" toggle won't be in the printout — expand
  or load it first if you need it on paper.
- For a more robust long‑term result where you control the theme, consider pairing
  or replacing this with a proper **print stylesheet**, which works with the
  browser's native print dialog and Save‑as‑PDF without JavaScript.
