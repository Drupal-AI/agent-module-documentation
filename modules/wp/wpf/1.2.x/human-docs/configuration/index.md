# Configuration

Webp fallback image has a small settings page plus a required setup on the Responsive
Image side. The settings page won't do anything on its own until your images are being
served as WebP through a responsive image style.

## The settings page

Go to **Configuration → Media → Webp fallback image settings**
(`/admin/config/media/wpf`). The route requires the *Administer wpf configuration*
permission. There are two settings:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Quality** | 75 | The JPEG quality (an integer) used when generating each fallback image. Lower it (e.g. 60) to shrink fallback files further; raise it for better-looking JPEGs. |
| **Disable fallback image for styles** | *(none)* | Tick any image styles here to **skip** JPEG-fallback generation for them — the WebP URL is left untouched for those styles. Leave everything unticked to generate fallbacks for all styles. |

Set the values you want and click **Save configuration**.

### Setting it from the command line

```bash
drush cget wpf.settings                 # the whole config object
drush cget wpf.settings quality          # -> 75
drush cset wpf.settings quality 60 -y     # lower the JPEG quality
```

## What it needs to actually work

The settings above only matter once WebP images are flowing through Responsive Image.
Make sure you have all three of these in place:

1. **Image styles that produce WebP.** Add core's **Convert** effect (to webp) to the
   image styles you use, so their derivatives are `.webp`.
2. **A responsive image style** (**Configuration → Media → Responsive image styles**)
   that references those WebP-producing image styles.
3. **That responsive image style in use** in an entity display — for example, set an
   image field's format to "Responsive image" and pick your responsive image style on
   the content type's *Manage display*.

With that pipeline in place, when a `<picture>` element is rendered `wpf` rewrites the
fallback `<img>` to point at a `.jpg` version of the WebP. The JPEG itself is generated
the first time a browser requests it — using GD's native WebP-to-JPEG conversion (or
ImageMagick) at your configured quality — so you never build fallbacks that go unused.
The module also removes orphaned fallback JPEGs automatically when the source file is
deleted or an image crop is updated.

## Notes

- Fallback JPEGs are generated on demand into the image-styles directory, so there is
  no need to commit them to version control.
- The mechanism supports both public and private image-style delivery routes.
- You can safely tune **Quality** per environment by changing `wpf.settings.quality`.
