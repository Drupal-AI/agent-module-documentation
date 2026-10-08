# Configuration

Ratio Crop has no settings page of its own. All of its configuration lives inside
the **image style** you add the effect to.

## Add the effect to an image style

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Click **Add image style** to create a new one (give it a name like *Card
   16:9*), or edit an existing style.
3. In the **Add a new effect** dropdown, choose **Ratio crop** and click **Add**.
4. Fill in the two settings (below), then click **Add effect** and **Save**.

## The two settings

- **Aspect ratio** — the ratio to crop to, written as `W:H` (width colon height),
  for example `16:9`, `1:1`, `4:3`, or `3:1` for a wide banner. The default is
  `1:1`. It must be two whole numbers separated by a colon; anything else is
  rejected with the message "Should be defined in H:W form."
- **Anchor** — which part of the image to keep when the longer side is trimmed.
  It's a 3×3 grid of positions (`horizontal-vertical`):
  - `left-top`, `center-top`, `right-top`
  - `left-center`, `center-center` *(default)*, `right-center`
  - `left-bottom`, `center-bottom`, `right-bottom`

  For example, choose `center-top` for portrait photos so faces near the top
  aren't cut off in a square crop, or `right-bottom` when your design overlays
  text in the top-left corner.

## How it behaves

- It keeps the **largest** area of the source that matches your ratio and trims
  only the longer dimension — it never upscales a small image.
- Because the effect calculates its output dimensions up front, the rendered
  `<img>` gets correct `width` and `height` and responsive image `srcset` sources
  stay accurate, which reduces layout shift.
- You can chain it with other effects: for instance, add a **Scale** effect after
  Ratio crop to first crop to the ratio and then resize to exact pixels.

## Using the style

Once saved, apply the image style anywhere image styles are used — an image
field's display formatter, a View, a responsive image mapping, or media library
thumbnails — and every rendered image is cropped to your chosen ratio.
