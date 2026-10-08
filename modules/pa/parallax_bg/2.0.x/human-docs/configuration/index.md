# Configuration

There's no global settings form — configuring Parallax Background *is* the list of
**Parallax elements** you create. Each element attaches the effect to one element on
the page.

## Open the Parallax elements list

1. Log in as a user with the **Administer parallax elements** permission.
2. Go to **Structure → Parallax elements**, or navigate directly to
   `/admin/structure/parallax_element`. You'll see the list of elements with **Add**,
   **Edit**, and **Delete** actions.

## Before you start: the element needs a background image

The parallax effect animates an element's **existing background image**. It doesn't
add a background for you — it layers motion on top of one. So make sure the element you
target already has a `background-image` set (usually via your theme's CSS) before you
expect to see anything move.

## Create a Parallax element, field by field

Click **Add** and fill in:

- **Valid jQuery selector** *(required)* — the CSS/jQuery selector of the element
  whose background gets the effect, for example `#top-content`, `#hero`, or
  `body.front #banner`. This is stored as the element's label. Scope it (like
  `body.front #banner`) if you only want the effect on certain pages.
- **Machine name** — an internal ID for the element, generated from the label.
- **Description** — an optional free-text note to remind you what this element is for.
- **Position** — the background's horizontal position: **Left** (`0`), **Center**
  (`50%`, the default), or **Right** (`100%`).
- **Speed** — the relative scroll speed, from `0` to `3` in steps of `0.1` (default
  `0.1`). Lower is subtle; higher is more dramatic. Give several elements different
  speeds for a layered depth effect.
- **Published** — only published (enabled) elements are applied on the front end.
  Uncheck it to switch an effect off without deleting its configuration.

Save the element. On every page where the selector matches, the bundled jQuery
parallax plugin applies the effect. Because the effect data ships to the browser via
`drupalSettings`, changes take effect once caches for the affected pages clear (the
module tags its output so edits invalidate correctly).

## Tips

- **Whole-page effect:** target `body` to give the entire page background a parallax
  feel.
- **Front page only:** scope the selector, e.g. `body.front #banner`, so the effect
  only runs where that selector exists.
- **Layered depth:** create several elements with different speeds.

## Security note

The selector you type is used directly as a live jQuery selector on the front end, so
treat **Administer parallax elements** as a trusted permission and grant it only to
roles you trust to author selectors.

## For developers

To adjust speed or position, or add/remove effects programmatically per page or theme
without editing the stored config, implement `hook_parallax_bg_settings_alter()`. See
the sibling [`agent/`](../agent/start.md) docs for the signature and an example.
