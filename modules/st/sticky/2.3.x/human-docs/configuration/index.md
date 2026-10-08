# Configuration

All of Sticky's behavior is set on one form, and it applies site-wide to the
single element you target.

## Open the settings form

1. Log in as a user with the **administer sticky** permission.
2. Go to **Configuration → System → Sticky**
   (`/admin/config/system/sticky`).

The values are stored in the `sticky.settings` config object, so they can be
exported and deployed.

## The DOM selector (the important one)

- **DOM selector** — the CSS selector of the element you want to make sticky
  (default `.menu--main`, the main menu). This is the one setting you must get
  right: `.header-wrapper`, `#footer`, `.menu--main`, and so on. The element must
  exist in the rendered page for anything to happen. Use your browser's inspector
  to find a reliable selector for the element you have in mind.

## JavaScript behavior options

These mirror the underlying garand/sticky plugin's parameters:

- **Top spacing** — a pixel gap kept above the stuck element. Set this to clear a
  fixed admin toolbar or another fixed header (e.g. `top_spacing` of a few dozen
  pixels).
- **Bottom spacing** — a pixel gap that lets the element unstick before it reaches
  the very bottom of the page.
- **Class name** — a CSS class added to the element while it is stuck (default
  `is-sticky`). Use it to style the "pinned" state (e.g. a shadow) in your theme.
- **Wrapper class name** — the class on the placeholder wrapper the plugin creates
  (default `sticky-wrapper`), in case you need to style or target it.
- **Center** — horizontally center the sticky element.
- **Get width from** — derive the sticky element's width from another element
  (give its selector) rather than from the element itself.
- **Width from wrapper** — constrain the sticky element's width to match its
  wrapper, which helps keep layout stable when the element becomes fixed.
- **Responsive width** — recalculate widths on window resize so the element
  behaves correctly in responsive layouts.
- **Z-index** — the stacking order of the sticky element over the rest of the page
  (default `auto`). Raise it if the pinned element ends up behind other content.

## Save

Click **Save configuration**. Reload a page with the targeted element and scroll
to confirm the new behavior. If nothing sticks, double-check the DOM selector
matches a real element and that the Sticky JS library is installed (see
[Installation](../installation/index.md)).
