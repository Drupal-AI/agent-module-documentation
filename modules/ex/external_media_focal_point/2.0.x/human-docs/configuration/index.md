# Configuration

This module has no global settings page. You configure it per image field, on that
field's **Manage form display**, through the widget's own settings.

## Set up Focal Point first

Focal Point stores its data using a crop type configured in the Focal Point
module's settings. Make sure Focal Point is set up as you normally would before
configuring this widget — this module reuses that configuration and your existing
image styles.

## Choose the widget on an image field

1. Go to **Structure → Content types → *(your content type)* → Manage form
   display** (or the equivalent screen for a media type or other fieldable
   entity).
2. Find the image field you want to use.
3. In its **Widget** column, choose **External Media with Focal Point**.

## Configure the widget

Click the gear/edit icon next to the field to open the widget's settings. Three
options are specific to this widget:

- **Preview image style** *(required)* — the image style used to render the
  thumbnail the editor drags the focal-point marker on. Pick a style that shows
  the whole image at a workable size. The widget's help text encourages choosing a
  style whose aspect ratio makes the focal point easy to judge.
- **Show preview link** — when enabled, adds a link that opens a full Focal Point
  preview in a modal, so the editor can check how the focal point affects the
  actual crops. The preview opens through a CSRF-protected route, so it's safe to
  expose.
- **Default focal point** — the focal point applied to new images before an editor
  moves it, given as `leftoffset,topoffset` in percent (for example `50,50` for
  dead centre). This value is validated by Focal Point's own validator, so an
  invalid entry is rejected — stick to two percentages separated by a comma.

Save the widget settings, then **Save** the Manage form display.

## What editors see

When an editor adds content, the field offers the External Media picker to import
or upload an image. Once an image is in place, a preview appears with a draggable
focal-point indicator; the editor drags it onto the part of the image that must
never be cropped out. The point is stored as a Crop entity using Focal Point's
crop type, and any Focal-Point image style will crop around it. If the image
already has a focal point, the widget loads that existing value. Both single- and
multi-value image fields are supported, and images can be captured directly from a
mobile device's camera.
