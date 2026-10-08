# Back To Top — manual setup guide

**Back To Top** (`back_to_top`) adds a small floating button that hovers over
the page and, when clicked, smoothly scrolls the visitor back to the top. It is
the classic "return to top" affordance you see on long blog posts and
documentation pages — no custom JavaScript or theme code required on your part.

The button appears automatically once a visitor scrolls past a distance you
choose, and fades away again when they scroll back up. Clicking it runs an eased,
animated scroll to the top of the page rather than jumping instantly, and that
animation politely cancels itself the moment the visitor scrolls, clicks, or
types — so it never locks up the screen. You can show a bundled image button or a
plain CSS/text button with your own label, and place it in any of nine positions
on the screen.

Everything is driven from a single settings form, and all of its options are
stored as exportable Drupal configuration, so you can build the button on one
environment and deploy it to another. The module depends only on Drupal core —
there are no third‑party libraries and no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, the button works immediately with its default settings. Its
settings form sits at **Configuration → User interface → Back To Top**
(`/admin/config/user-interface/back_to_top`). Access to that form is controlled
by the single **Access Back To Top settings** permission
(`access back_to_top settings`), so you can let a non‑administrator role tune the
button without granting broader access.

## How to use it

There is nothing you must configure — enable the module and a button appears at
the bottom right of long pages. To adjust it, open the settings form above. The
form is a single page with these options:

- **Button type** — choose the bundled **Image** button (a PNG icon, the default)
  or a **Text** button that shows a label you set.
- **Button text** — the label shown inside the button (default *Back to top*).
  Used by both button types.
- **Position** — one of nine screen positions: bottom, top, or middle, each
  paired with left, center, or right. The default is bottom right.
- **Trigger distance** — how many pixels the visitor must scroll before the
  button fades in (default 100).
- **Scroll speed** — the duration of the scroll‑to‑top animation in milliseconds
  (default 1200); lower is faster.
- **Text button colors** — background, border, hover, and text colors that apply
  only to the text button. Leave them at their defaults and your theme's own
  styles take over; change them and the module injects matching inline CSS.

Three visibility toggles let you keep the button out of the way:

- **Prevent on mobile** — hide it on touch screens up to 760px wide.
- **Prevent in admin** — do not show it on administration pages or node edit
  forms.
- **Prevent on the front page** — show it only on interior pages.

Click **Save configuration** and the changes take effect on the next page load.
