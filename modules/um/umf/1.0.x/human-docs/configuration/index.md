# Configuration

Universal Media formatter has no global settings page. Instead you configure it
per field, on the display where you want it, using the standard *Manage display*
interface.

## Enable the formatter on a field

1. Go to **Structure → (your content type or other entity) → Manage display**
   (for example `/admin/structure/types/manage/article/display`), and pick the
   view mode you want to change if it's not the default.
2. Find an **entity‑reference field whose target is Media** (the formatter only
   appears for media‑target reference fields).
3. In the **Format** column, choose **Universal Media formatter**.
4. Click the gear icon to open its settings.

## Settings, field by field

- **Responsive image style** *(required)* — the responsive image style used to
  render JPEG/PNG thumbnails. Choose one that has image‑style mappings defined.
  This is the core of what the formatter does, so you must pick one.
- **Link image to** — leave empty for no link, or link the image to the **host
  content** (the entity that references the media) or to the **media item**
  itself.
- **Loading** — the browser `loading` attribute: **lazy** (default, defers
  off‑screen images) or **eager** (load immediately, good for above‑the‑fold
  images).
- **Fetch priority** — the `fetchpriority` attribute: **high** for important
  above‑the‑fold media, **low** for background/decorative media, or leave it to
  the browser default.
- **Width** and **Height** — set native `width`/`height` attributes on the
  rendered image (helps the browser reserve space and avoid layout shift).
- **Aspect ratio** — emitted as an inline `aspect-ratio` CSS value, useful for
  keeping media placeholders stable while images load.
- **Border radius** — emitted as an inline `border-radius` CSS value to round the
  image's corners.
- **Fallback view mode** *(required)* — the media view mode used as a fallback. It
  is used to render **video** media (so you get the video rather than a generic
  still) and is passed through when the formatter renders the media entity
  directly.

Save the display when you're done.

## What the formatter does at render time

For each referenced media item, the formatter loads its thumbnail file, copies the
source field's alt text onto it, and renders based on the file type:

- **JPEG/PNG** → rendered through core's responsive image formatter using your
  chosen responsive image style (full `srcset`/`sizes` output).
- **SVG** → rendered through the plain image formatter, served as‑is (image styles
  don't apply to SVGs).
- **Video** (detected by the generic video thumbnail) → the media entity is
  rendered in the **fallback view mode** you selected, so the actual video plays.

It also checks each media item's **view** access before rendering, so unpublished
or restricted media isn't exposed, and it attaches cache tags for the responsive
image style, its image styles, and each media entity so the display invalidates
correctly when any of those change.
