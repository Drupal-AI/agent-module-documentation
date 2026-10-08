# Configuration

SVG image has **no dedicated settings page**. You turn SVG support on one field
at a time and control how it displays through Drupal's normal field and display
forms. There are two short steps: allow the upload, then choose how it renders.

## 1. Allow SVG uploads on a field

1. Log in as a user who can administer content types (an administrator by
   default).
2. Go to **Structure → Content types → [your content type] → Manage fields**,
   click the image field you want to use, and open its **settings**.
3. Find **Allowed file extensions** and add `svg` to the list, for example:

   ```
   png gif jpg jpeg svg
   ```

4. Save the field settings.

Once `svg` is allowed, the SVG‑aware widget takes over for that field: it permits
the `.svg` upload, removes core's "file is an image" validator, and shows a real
SVG preview in the node edit form. The same works on user picture fields, media,
or any entity that uses a core Image field.

## 2. Choose how SVGs display

Displays are configured under **Structure → Content types → [your content type]
→ Manage display**. For the image field, click the gear/settings icon next to its
**Format** (the standard *Image* formatter). SVG image adds two extra options
here:

- **Render as image** *(on by default)* — when **ticked**, each SVG is output as
  an ordinary `<img>` tag, just like a JPG or PNG. When **unticked**, the SVG is
  embedded directly into the page as inline `<svg>` markup. Inline output is
  sanitized with the `enshrined/svg-sanitize` library (and its `<?xml…?>` and
  `<!DOCTYPE…>` declarations are stripped), and it lets you style the SVG's fills
  and strokes with CSS — useful for icons and logos that should pick up theme
  colors.
- **Width** and **Height** — optional pixel values that force explicit
  dimensions on the rendered SVG. Leave them empty to let the module derive
  dimensions from the SVG's own attributes (falling back to 64×64) and any image
  style you have selected.

A note on image styles: SVGs are resolution‑independent, so image styles cannot
crop or resize them on the server. When you pick an image style for an SVG, the
**URL to image** formatter (`image_url`) simply returns the original file URL,
and rendered SVGs carry a `no-image-style` class so the styling degrades
gracefully. Raster images (JPG/PNG) in the same field continue to honor the image
style as normal.

## Save

Click **Save** on each form. Reload a page that shows the field and your SVGs
will render — as `<img>` tags or inline markup, depending on the choice above.
