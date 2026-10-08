# Configuration

One Click Accessibility works as a block plus a small settings form. There are
two things to do: place the block so visitors can see the widget, and adjust the
settings so it offers the helpers and position you want.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the **Extend** page and click **Configure** next to *One Click
   Accessibility*, or find it in the **Configuration** section of the admin menu.
   The form is registered as `one_click_accessibility.settings`.

## Choose the widget position

The headline setting is which side of the browser window the widget floats on —
**Left** or **Right**. Pick the side that stays clear of your theme's other
fixed elements (a cookie banner, a chat launcher, a back‑to‑top button) so the
controls do not overlap.

## Choose which helpers to offer

The accessibility tools the widget can present are:

- **Increase / Decrease text size** — steps the on‑page font size up or down.
- **Grayscale** — removes colour, rendering the page in shades of grey.
- **High contrast** — boosts the contrast between text and background.
- **Negative contrast** — inverts colours for a light‑on‑dark view.
- **Light background** — forces a plain light background behind content.
- **Underline links** — underlines every link so they stand out from body text.
- **Readable font** — swaps in a plainer, easier‑to‑read typeface.

Enable the set that suits your audience, then **save** the form.

## Place the block

The widget is delivered as a block. Go to **Structure → Block layout**, place the
**One Click Accessibility** block in a region that renders on every page (a header
or footer region is typical), and save. Because the widget floats to the side you
chose above, the exact region matters less than making sure the block is present
site‑wide.

## Save

Save both the settings form and the block layout. Reload a front‑end page and the
accessibility widget should appear, offering the helpers you enabled. Every choice
a visitor makes applies only to their own browser session — nothing they toggle
changes the site for anyone else.
