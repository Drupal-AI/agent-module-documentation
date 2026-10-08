# Configuration

Configuring Textimage has three parts: the **global settings form**, the
**per‑image‑style options**, and the **field formatters** you apply on Manage
display.

## The settings form

Go to **Configuration → Media → Textimage** (`/admin/config/media/textimage`). This
form needs the **Administer site configuration** permission. Its fields:

- **Default output format / extension** — the file format (PNG, GIF, or JPG) that
  Textimage writes its generated images as, unless an effect such as "Convert"
  overrides it. The default is **PNG**. This only affects Textimage derivatives, not
  core Image module derivatives.
- **Default font** — register a font file here so every "Text overlay" effect has a
  font available even if one wasn't chosen explicitly.
- **URL generation — enabled** — turn on direct image generation from a URL path.
  Off by default. When on, requesting a Textimage URL builds the image on demand.
  Only meaningful together with the permission below and an image style whose
  Textimage destination is public.
- **URL generation — text separator** — the delimiter (default `---`) that splits
  the text in a generation URL into separate "Text overlay" effects.
- **Debug** — log Textimage operations to the `textimage` logger channel. Leave off
  in production.

Click **Save configuration** to apply.

### Cleanup

The same settings area has a **Cleanup Textimage** action
(`/admin/config/media/textimage/cleanup`) that deletes every Textimage‑generated
file, flushes the image styles, and clears the cache/store records. **Note:** this
also flushes core Image module derivatives, so all image derivatives will be rebuilt
on next request.

## Per‑image‑style "Textimage options"

When you edit any image style (**Configuration → Media → Image styles**) that
contains a "Text overlay" effect, Textimage adds a **Textimage options** section.
The key choice there is the **Image destination** — the stream wrapper (for example
**public** or **private**) where Textimage stores derivatives built from that style.
Choose **private** to keep generated images access‑controlled. This affects only
Textimage's own derivatives.

## The field formatters

Apply these on an entity's **Manage display** tab. Both require an image style that
contains a "Text overlay" effect.

### Textimage text formatter

For **text**, **long text**, and **text with summary** fields. The field's text
becomes the overlay text. Options:

- **Image style** — the template style (with a Text overlay effect) used to build the
  image.
- **Text values** — for multi‑value fields, choose whether to produce a single
  combined image or one image per value.
- **Link image to** — nothing, the **content** (entity), or the **image file**.
- **Alt text** — the generated image's `alt` attribute; tokens are allowed, and it
  falls back to the field's own alt.
- **Title** — the image's `title` attribute; tokens are allowed.
- **Defer image building** — build the image on a later request rather than during
  the current render.

### Textimage image formatter

For **image** fields. The overlay text comes from the Text overlay effect's default
text, and the uploaded image is available as token context. Options:

- **Image style**, **Link image to**, **Alt text**, and **Title** — as above.
- **Image loading** — the HTML `loading` attribute, **lazy** or **eager**.

### Tokens in overlay text

You can put tokens like `[node:title]` directly in the overlaid text so each node
produces its own image. The text formatter resolves tokens against the node and
user; the image formatter also resolves `file` tokens for the uploaded image.

## Permissions

- **Generate Textimage URL derivatives** (`generate textimage url derivatives`) —
  allows a user to generate images directly from a URL request. This only matters
  when **URL generation** is enabled on the settings form. Keep it off for anonymous
  users unless you deliberately want a public image‑generation endpoint, otherwise
  anyone could create arbitrary images on demand.

The settings and cleanup pages themselves are gated by core's **Administer site
configuration** permission.
