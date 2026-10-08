# Configuration

Automated Crop has no settings page. You use it by adding its **image effect** to
an image style; the configuration lives on the style.

## Add the effect

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. **Add image style** (or edit an existing one).
3. Under **Effect**, choose **Automated Crop** and click **Add**.
4. Configure the effect's two options (below).
5. Save the effect, then save the style.

## The effect's options

- **Crop type** *(required)* — a Crop module crop type, such as `focal_point`,
  `freeform`, or a custom one. The aspect ratio and the hard/soft size limits that
  drive the automatic crop all come from this crop type.
- **Automatic crop provider** *(required)* — which cropping strategy computes the
  crop box. This defaults to **Automated crop** (`automated_crop_default`), which
  centres a crop box sized from the crop type's aspect ratio and never exceeds the
  original image. This select only appears once at least one provider is
  registered (the default one always is). If you install additional
  `AutomatedCrop` plugins, they appear here as extra choices.

## What happens when the style runs

When an image is rendered through the style, the effect:

1. Checks the crop type is valid (and aborts with a logged error if it is
   missing).
2. Looks for an existing stored crop for that image and crop type — for example a
   Focal Point crop an editor placed. If one exists, it is used.
3. If none exists, it asks the chosen provider to compute a crop, then saves that
   as a crop entity so it is reused next time.
4. Crops the image to the resulting box.

This is why Automated Crop pairs so well with Focal Point: editors' manual crops
win where they exist, and everything else is cropped automatically and
consistently.

## Deploying the configuration

The effect and its settings are stored on the image style config entity
(`image.style.<style>`), so they travel with a normal configuration export. The
effect also declares a dependency on the crop type you selected, so exports stay
consistent.
