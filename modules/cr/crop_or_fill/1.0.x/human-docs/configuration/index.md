# Configuration

Crop or Fill is configured as an **effect on an image style**, not through a
module-wide settings page. You add the effect to whichever image style needs the
crop-or-pillarbox behavior and set its two options there.

## Add the effect to an image style

1. Log in as a user with the **Administer image styles** permission (an
   administrator by default).
2. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
3. Edit an existing image style or click **Add image style** to create one.
4. In the **Add a new effect** dropdown, choose **Crop or fill** and click **Add**.

You'll be taken to the effect's settings.

## Effect settings

- **Crop type** — select which crop type to use. This is inherited from the Crop API,
  so it's one of the crop types you've already defined. The crop type's aspect ratio
  is what Crop or Fill compares the image's orientation against to decide whether to
  crop or to pillarbox. If a crop type has no ratio (free-form), the effect simply
  delegates to a standard crop.
- **Background color** — a hex color picker for the fill bars used when the image and
  target orientations differ. The default is white (`#ffffff`). Pick a brand color
  or a neutral shade that suits where these images appear.

Save the effect, then **Save** the image style.

## How it behaves once configured

When the image style is applied to an image:

- If the image and the crop type's ratio share an orientation (or the crop is
  square), the image is cropped normally.
- If they are opposite orientations, the image is centered on a canvas of the target
  ratio filled with your chosen background color — no part of the image is lost.

This gives you consistent output dimensions across mixed-orientation images, which
is exactly what you want for galleries, teasers, and thumbnails.
