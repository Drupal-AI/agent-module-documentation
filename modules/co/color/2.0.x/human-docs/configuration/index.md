# Configuration

Color has no page of its own. Its picker is injected into the settings form of
each **compatible** theme, so you configure it one theme at a time.

## Open a theme's color picker

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Appearance** (`/admin/appearance`) and click **Settings** next to the
   theme you want to recolor, or navigate directly to
   `/admin/appearance/settings/{theme}`.
3. Scroll to the **Color scheme** section. If you don't see one, the theme isn't
   color‑compatible or PHP GD/PNG support is missing.

## The Color scheme form

- **Color set** — a dropdown of predefined schemes the theme ships (for example
  a "default" palette), plus a **Custom** option. Pick a named set to start from
  a designer‑chosen palette, or choose **Custom** to set every color yourself.
- **Palette fields** — one hex text field per recolorable element the theme
  exposes (typically *base*, *text*, *link*, and so on). Enter a color as a hex
  value — either short `#rgb` or full `#rrggbb`. Anything that isn't a valid hex
  color is rejected on save.
- **Color‑wheel picker** — a farbtastic picker lets you choose colors visually
  instead of typing hex codes; clicking into a palette field and using the wheel
  updates that field.
- **Preview** — a live HTML preview shows how the chosen colors will look before
  you commit, so you can experiment safely.

## Save and what happens next

Click **Save configuration**. On save, Color:

1. Writes recolored copies of the theme's stylesheets into your public files
   directory.
2. If the theme provides a base image, GD‑renders recolored images and a
   recolored logo (the new logo is applied to the site's branding block
   automatically).
3. Stores the palette and the generated file paths in a `color.theme.<theme>`
   config object.

Reload the site and your new palette is live. Because the colors are compiled
into CSS files on disk, editing the `color.theme.<theme>` config directly does
nothing useful — always change colors through this form and re‑save to
regenerate the files.

## Rolling back

To return a theme to its original colors, re‑select its **default** color set
and save. Choosing the exact default palette removes the stored `color.theme.<theme>`
config, so the theme falls back to its own shipped CSS.

## Tips

- Each compatible theme keeps its **own** independent scheme, so you can brand
  several themes differently on the same site.
- If you edit a theme's source CSS later, re‑save the color form to regenerate
  the recolored stylesheets from the new source.
