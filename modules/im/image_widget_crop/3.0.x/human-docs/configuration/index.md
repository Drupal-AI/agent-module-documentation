# Configuration

Setting up Image Widget Crop has two parts. First there is a single **global
settings page** that controls the crop preview and where the Cropper library is
loaded from. Second — and this is where the real work happens — there is a
**three-step setup flow** that wires cropping onto an actual image field: create a
crop type, build an image style that uses it, and switch the field's widget to the
cropping widget. Both parts are covered below.

## Global widget settings

### Open the settings page

1. Go to **Configuration → Media → Image Crop Widget**
   (`/admin/config/media/crop-widget`).
2. The page has two collapsible sections plus a **Save configuration** button.

![The Image Crop Widget settings page](../images/settings.png)

### Cropper library settings

Expand **Cropper library settings** to control where the Cropper JavaScript library
that powers the crop interface is loaded from. Image Widget Crop bundles Cropper, so
you can normally leave these blank; fill them in only if you want to serve the
library from a CDN or a local path of your own:

- **Library URL** — the URL to the Cropper JavaScript file. Leave empty to use the
  bundled copy.
- **CSS URL** — the URL to the Cropper stylesheet. Leave empty to use the bundled
  copy.

### General configuration

Expand **General configuration** for the behaviour that applies to every crop
widget on the site:

- **Crop preview image style** — the image style used to render the live preview of
  the crop as the editor drags. The default is *Crop thumbnail* (`crop_thumbnail`).
- **Warn about multiple usages** — when enabled, editors are warned if they crop a
  file that is also used elsewhere, so one person's crop does not silently change
  another place the same file appears. Off by default.
- **Show default crop** — when enabled, the widget shows a default crop selection
  before the editor has drawn one. On by default.
- **Notify when a crop is applied** — show a status message when a new crop is
  applied. Off by default.
- **Notify when a crop is updated** — show a status message when an existing crop is
  changed. On by default.

These values also act as the **defaults** for the per-field widget settings you will
set in Step 3 below — a field can override them.

### Save

Click **Save configuration** to store your changes.

---

## The setup flow: cropping on a real image field

The global page above does not, on its own, make cropping appear anywhere. To get a
working crop widget you complete three steps in order.

### Step 1 — Create your crop type(s)

Crop types are defined by the **Crop module**, not by Image Widget Crop. A crop type
is a named crop shape — for example "16:9 hero" or "square thumbnail" — with an
optional aspect ratio and size limits.

1. Go to **Configuration → Media → Crop types** (`/admin/config/media/crop`).
2. Click **Add crop type** and give it a label (e.g. *Hero 16:9*), an aspect ratio,
   and any hard/soft limits you need, then save.

Create one crop type for each distinct framing you want editors to control. Full
click-by-click instructions are in the
[Crop module's configuration guide](../../../../crop/2.6.x/human-docs/configuration/index.md).

### Step 2 — Create image styles that use the "Manual crop" effect

A crop type only takes visible effect when an image style renders through it. For
each crop type, create (or edit) an image style and add the **Manual crop** effect
pointing at that crop type.

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Click **Add image style**, give it a name (e.g. *Hero 16:9*), and save.
3. On the style's edit page, under **Effect**, choose **Manual crop** and click
   **Add**.
4. Select the **crop type** this effect should use (the one you made in Step 1),
   then **Add effect**. Optionally add a *Scale* or *Resize* effect after it to fix
   the final output dimensions.
5. Save the image style.

Now, wherever this image style is used to display the field, it will render using
the region the editor cropped for that crop type.

### Step 3 — Switch the image field to the ImageWidget crop widget

Finally, turn the cropping widget on for the image field you want editors to crop.
This is done per **form display** on whatever entity owns the field (a content type,
a media type, etc.).

1. Go to **Structure → Content types**, find the content type whose image field you
   want to crop, and open its **Manage form display** tab
   (e.g. `/admin/structure/types/manage/article/form-display`).
2. Find your image field in the list. In its **Widget** column, change the widget
   from *Image* to **ImageWidget crop**.
3. Click the gear/edit icon at the end of that row to open the widget settings, and
   configure:
   - **Crop list** — the crop types (from Step 1) that this field offers. Tick every
     shape editors should be able to draw on this field.
   - **Crop types required** — of the crop types above, which ones the editor *must*
     define before the entity can be saved.
   - **Crop preview image style** — the image style used for the crop preview on this
     field (defaults to the global preview style).
   - **Preview image style** — the style used to preview the uploaded image itself.
   - **Progress indicator** — how upload progress is shown (*throbber* or *bar*).
   - **Always expand crop area** — keep the crop tool open rather than collapsed.
   - **Warn about multiple usages** — warn if the file is used in more than one place
     (defaults to the global setting).
4. Click **Update**, then **Save** the form display.

Open a node of that content type and edit or add an image: you will now see the
Cropper interface with a tab for each crop type you enabled, letting the editor draw
each crop by hand.
