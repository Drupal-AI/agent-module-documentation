# Configuration

Square Pixels Scale has no settings page of its own — you configure it as an effect
inside a Drupal image style. Its options appear once you add the effect.

## Add the effect to an image style

1. Log in as an administrator.
2. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
3. Edit an existing image style or add a new one.
4. From **Add a new effect**, choose **Square pixels scale** and click **Add**.

## The effect's options

Once the effect is added, you can set:

- **Total square pixels** — the target area for the scaled image, approximated by
  multiplying the output width by its height. The actual result will usually be
  slightly above or below this number rather than exact. The original aspect ratio
  is always kept.
- **Maximum width** *(optional)* — an upper limit on the scaled image's width. Use
  it to stop very wide images from becoming too large even when the area target
  would allow it.
- **Maximum height** *(optional)* — an upper limit on the scaled image's height,
  for the same reason.
- **Allow upscaling** — when ticked, the effect may enlarge an image beyond its
  original size to reach the target area. Leave it off if you only want to scale
  images down.

## Save

Save the effect, then save the image style. Apply that image style wherever the
images are displayed (an image field's display formatter, a view, and so on), and
your mixed‑aspect‑ratio images will render at more consistent visual sizes.
