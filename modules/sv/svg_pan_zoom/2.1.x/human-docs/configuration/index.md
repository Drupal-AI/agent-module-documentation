# Configuration

SVG Pan Zoom has no site‑wide settings form. You configure it **per view‑display**
by choosing its formatter on an image field and adjusting that formatter's
settings.

## Set the formatter

1. Log in as a user who can administer display settings (an administrator by
   default).
2. Go to the content type (or any entity) whose image field you want to make
   interactive — for example **Structure → Content types → Article → Manage
   display**.
3. Find your SVG‑capable image field and, in its **Format** column, choose
   **Svg Pan Zoom**.
4. Click the gear/cog icon next to the field to open the formatter settings.

## Formatter settings, field by field

- **Width / height** — text values applied as attributes on the rendered element.
  Leave blank to use the SVG's intrinsic size.
- **Display** — how the SVG is placed on the page:
  - **embed** — wraps the file in `<embed type="image/svg+xml">` pointing at the
    file URL. This is sandboxed and the **safest** option.
  - **inline** — reads the SVG file and prints its markup directly into the page,
    which lets you style or script the SVG's internals with CSS/JS.
- **Pan enabled** — allow dragging to pan around the image.
- **Zoom enabled** — allow zooming at all. Turn this off (while leaving pan on) to
  offer pan‑only viewing.
- **Control icons enabled** — show on‑screen zoom buttons.
- **Double‑click zoom enabled** — zoom in on a double‑click (handy on touch
  screens).
- **Mouse‑wheel zoom enabled** — zoom with the scroll wheel.
- **Prevent mouse events default** — stops the library's mouse events from
  bubbling to the page.
- **Zoom scale sensitivity** — how much each zoom step changes the scale; lower
  values give finer zooming.
- **Min zoom / Max zoom** — the lower and upper zoom bounds, useful to stop a map
  or diagram from zooming out to nothing or in past legibility.
- **Fit / Contain / Center** — how the SVG is sized and placed within its
  container when it first loads.
- **Refresh rate** — the library's `refreshRate`, either `auto` or a number;
  worth tuning for animation‑heavy SVGs.

Each setting is emitted as a `data-*` attribute on the rendered element and read
by the module's JavaScript, which initialises svg-pan-zoom on those elements.

## Save

Click **Update** on the formatter settings, then **Save** on the Manage display
page. View a piece of content with an SVG in that field and you should be able to
pan and zoom.
