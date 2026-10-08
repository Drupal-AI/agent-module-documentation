# Configuration

Insert has **two** configuration layers. The **global settings** page controls site‑wide
behaviour and which widget types Insert attaches to. The **per‑field settings** on Manage
form display decide, for each individual file or image field, whether the Insert button
appears and which styles it offers. In everyday use you will spend most of your time in
the per‑field settings — the global page is set once and rarely revisited.

## Global settings

Go to **Configuration → Content authoring → Insert** (`/admin/config/content/insert`). You
need the core **Administer filters** permission. The options here are:

- **Absolute URLs** — when on, inserted links and image `src` values use the full base URL
  instead of a relative path.
- **File field images enabled** — when on, images uploaded to a plain *file* field (not an
  image field) can also be inserted as `<img>` and offered image styles.
- **Widgets** — the list of file‑widget and image‑widget plugin types that Insert attaches
  to. By default these are core's *file* and *image* widgets; add a contrib widget's plugin
  here to enable Insert on it.
- **CSS classes** — extra CSS classes added to every inserted file link or image, site‑wide.
- **Audio/video file extensions** — which uploaded file extensions are detected as audio
  (rendered as `<audio>`) or video (rendered as `<video>`). By default `mp3` is audio and
  `mp4` is video.

If you enabled the **Insert Colorbox** submodule, its own options are added to this same
settings page.

## Per‑field settings (Manage form display)

This is where you actually turn Insert on for a field and choose what it offers.

1. Go to the bundle's **Manage form display** tab — for example
   **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
2. Find the file or image field's row and click its **cog / gear** icon to open the widget
   settings.
3. Under the **Insert** section, configure:
   - **Styles** — tick every insert style you want to offer the editor. Options include the
     **AUTOMATIC** default, **Link to file**, **Embed audio/video**, **Original image**, and
     one entry per configured **image style**, plus any styles added by the submodules
     (Colorbox, responsive image, media view modes). **This is the on/off switch: if no
     style is ticked, no Insert button appears for the field.**
   - **Default style** — the style pre‑selected for the editor (AUTOMATIC by default).
   - **Automatic image style** *(image fields)* — the image style the AUTOMATIC option uses.
   - **Link image to** *(image fields)* — an image style the inserted image should link to
     (for example a thumbnail that links to the full image), or none.
   - **Maximum width** — a maximum insert width in pixels. This is applied in the HTML output
     only; it does not resize the underlying file.
   - **Rotation controls** *(image fields)* — whether editors get controls to rotate the
     image before inserting.
4. Click **Update** on the field row, then **Save** the form display. The field's summary
   line then reads *Insert: &lt;styles&gt;* (or *Insert: disabled* if you left styles empty).

Repeat for each field where you want Insert. Because these are per‑field, per‑form‑mode
settings, you can offer different styles on different content types.

> **Site‑specific gotcha:** on sites running **Lightning Media** (`lightning_media_image`),
> the first save of a *new* image‑field form‑display component is intercepted and swapped to
> an entity‑browser widget, which drops your Insert settings. If that happens, set the image
> widget and save once, then set it **again** (it is no longer "new") with your Insert
> options and save a second time so they stick. Plain file fields are unaffected.

## Deploying the configuration

The global options live in the `insert.config` object and the per‑field options live on each
`entity_form_display` component, so both export and import as regular configuration — set
Insert up once and deploy it across environments like any other config.
