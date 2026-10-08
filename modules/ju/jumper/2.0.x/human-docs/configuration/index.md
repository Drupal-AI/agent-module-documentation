# Configuration

Jumper has no central settings form — every option lives on the **Jumper** block
you place. This page walks through those block settings field by field.

## Place the block

1. Log in as a user who can administer blocks (an administrator by default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in your chosen region (a footer is typical) and pick the
   block from the **Jumper** category.

The block configuration form opens with the fields below.

## Scroll target and motion

- **Target** — a single CSS selector to scroll to, such as `#header` or `#main`.
  Leave it as the default to jump to the top of the page. A plain number is treated
  as a pixel target instead of a selector.
- **Duration** — how long the scroll animation takes, in milliseconds (default
  **1000**).
- **Offset** — a pixel offset applied when jumping to an element. Use a negative
  value to stop *above* a fixed header so it doesn't cover the target.

## When the button appears

- **Visibility** — the activation point, in pixels. The button stays hidden until
  the visitor has scrolled this far down the page, then fades in (the check is
  debounced, roughly every 250 ms).

## Appearance

- **Icon** — a custom icon class from FontAwesome or the Icon API, for example
  `fa fa-angle-up`, used as the button's glyph.
- **Color** — one of the provided background colours (grey, dark, purple, orange,
  blue, lime, or red), or leave empty for none.
- **Style** — a rounded style (`round`, `round-2`, `round-8`, or `round-12`), or
  leave empty for a square button.
- **Text** — the button's label. Only a `<span>` tag is allowed here. It's shown
  when *No text* is off.
- **No text** — tick this to visually hide the label and show an icon‑only button.

## Advanced behaviour

- **Selectors** — extra, comma‑separated CSS selectors that should *also* act as
  jumpers, so other links on the page trigger smooth scrolling.
- **Out of the block (ootb)** — renders the jumper as a direct child of `<body>`
  rather than inside the block wrapper. Turn this on if your theme's fixed
  positioning conflicts with the button's placement or layering.
- **Auto Views Load More (autovlm)** — automatically triggers a View's *Load More*
  when the visitor reaches the jumper, for scroll‑based auto‑loading.

## Save

Click **Save block**. Changes take effect immediately.

> **Positioning tip:** the block sits at the bottom‑right by default. To move it,
> add a small CSS override — for example, target `.jumper.jumper--block` and set
> `left` to reposition it to the bottom‑left or centre.
