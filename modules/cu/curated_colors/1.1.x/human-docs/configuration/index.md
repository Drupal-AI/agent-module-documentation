# Configuration

Setting up Curated Colors is two steps: **create a palette**, then **use it** —
either through a field on an entity or through a Drupal Canvas component prop.

## 1. Create and manage palettes

1. Log in as a user with permission to administer Curated Colors.
2. Go to **Configuration → Content authoring → Curated Colors**
   (`/admin/config/content/curated-colors`). This is the palette **collection**,
   where all your palettes are listed.
3. Add a palette and give it a name. A palette is a config entity, so it will be
   exportable and tracked in git.

Within a palette you build up the list of colors. Each color entry has:

- **Machine key** — the value that actually gets stored, e.g. `brand-primary`.
  This is what your theme keys off, so choose something stable and meaningful.
- **Label** — the human‑readable name editors see, e.g. "Brand primary".
- **Hex value** *(optional)* — used only for the swatch preview in the admin UI.
  It is not what appears on the front end unless you deliberately output it.
- **Custom CSS** *(optional)* — a CSS string for anything a single hex can't
  express, such as a gradient.

Colors can be sorted into named **groups** and dragged to reorder, and the editor
shows live preview swatches as you build the palette.

## 2. Add a Curated color field

To let editors pick a color on content:

1. On a content type (or any fieldable entity), go to **Manage fields → Add
   field** and choose the **Curated color** field type.
2. In the field settings, pick which **palette** this field uses. You can
   optionally **restrict the picker to specific groups** within that palette, so a
   given field only offers, say, the "primary" colors.
3. On **Manage form display**, the field uses a swatch‑based popover widget —
   colors appear as clickable swatches in labeled group sections, and the popover
   repositions itself to stay on screen.
4. On **Manage display**, choose a formatter. Two are provided: a **swatch chip
   with label**, and a **plain value** formatter that can output the key, hex,
   label, or CSS string.

The field also exposes computed properties for use in Twig templates and SDC
props: `value` (the stored key), `hex`, `style` (the custom CSS string, if set),
`label`, and `css` (custom CSS if set, otherwise a `background:#hex` declaration
ready to drop into a `style` attribute).

## 3. Use it in a Drupal Canvas component (optional)

If the Canvas module is installed, annotate any SDC string prop with
`x-curated-color-palette` and it uses the swatch picker in the component editor —
whether the prop is bound to a field or set as a static value:

```yaml
# my_component.component.yml
props:
  properties:
    color:
      type: string
      x-curated-color-palette: brand
```

## Rendering colors in your theme

The recommended pattern is to render the color **from your stylesheet, not from
the stored value**. The picker stores hex/custom CSS so the admin UI can preview
the palette, but in production you map the stored key to a CSS class or custom
property, so your theme owns the real color values:

```css
.my-component--brand-primary .my-component__accent { background: #0678be; }
.my-component--brand-warm    .my-component__accent { background: linear-gradient(…); }
```

For inline styles, SVG fills, or email templates where a CSS class won't work, the
computed `css` property gives you a ready‑made background declaration. The
`curated_colors_example` submodule shows both approaches with a working component.

> **Tip:** The same mechanism works for any constrained set of options with visual
> meaning — for example button style variants. Define a palette whose keys are
> style options (`btn-primary`, `btn-secondary`, …) instead of colors, and editors
> get the same visual chooser.
