# Configuration

Logo Image Enhanced is configured on the **theme settings** page, not a page of
its own. Everything below lives in the **Logo Image Enhanced** fieldset that the
module adds there.

## Open the settings

1. Log in as a user with the **Administer themes** permission (an administrator by
   default).
2. Go to **Appearance → Settings** (`/admin/appearance/settings`). To configure a
   specific theme rather than the global defaults, open that theme's own settings
   page.
3. In the **Logo image settings** area, expand the **Logo Image Enhanced**
   fieldset.

## Upload the logo

Use the standard logo upload control. Because the module extends the accepted
formats, you can now upload **WebP, AVIF, SVG, and APNG** files in addition to
core's formats — or keep using the logo you already have.

## Image Style

Choose any existing Drupal **image style** to apply to the logo (resize, scale,
optimize, and so on). This is the main win over core, which cannot style the logo
at all. Create image styles first at **Configuration → Media → Image styles** if
you need one that doesn't exist yet.

**SVG note:** if your logo is an SVG, the image style is automatically skipped —
vector images can't be raster‑processed — but the alt/title and performance
attributes below still apply.

## Alt text (required)

The alternative text announced by screen readers and shown if the image fails to
load. This field is **required** for accessibility (WCAG) and helps SEO. Write
something meaningful, typically your organisation or site name.

## Title

Optional `title` attribute for the logo — the tooltip shown on hover. Leave it
blank if you don't need one.

## Image loading attribute

Controls the browser's `loading` attribute:

- **Eager** *(recommended for logos)* — load the image immediately. Logos are
  almost always above the fold, so eager loading avoids a visible delay.
- **Lazy** — defer loading until the image is near the viewport. Rarely the right
  choice for a header logo.

## Fetchpriority attribute

Hints to the browser how important the logo is to fetch: **None**, **High**,
**Low**, or **Auto**. Setting **High** for an above‑the‑fold logo can help your
Core Web Vitals (specifically Largest Contentful Paint).

## Decoding attribute

Controls how the browser decodes the image: **None**, **Async**, **Sync**, or
**Auto**. **Async** lets the browser decode the image without blocking other
rendering; leave it on **None**/**Auto** unless you have a specific reason.

## Debug mode

An optional toggle. When enabled, a floating diagnostic panel appears in the
bottom‑right corner **for administrators only**, showing the logo configuration,
the loading/fetchpriority/decoding values, image dimensions, DOM analysis, and
the JS settings. Use it to troubleshoot rendering in complex or contributed
themes — and **disable it in production**.

## Save

Click **Save configuration**. Changes apply immediately site‑wide, and the module
flushes the relevant caches and image‑style derivatives for you — no manual cache
clear needed. The module also applies proper width/height attributes after
styling to reduce layout shift (CLS).
