# Image effect catalog

Add these on **Admin → Config → Media → Image styles** → *Add effect* (they extend core's
`ImageEffect` plugin type; classes in `src/Plugin/ImageEffect/`). Some require the ImageMagick
toolkit.

| Effect (class) | Does |
|---|---|
| Watermark | Composite a logo/image over the source (position, opacity, scale). |
| Text Overlay | Render text onto the image (font, size, color, angle, wrap, anchor); alterable via hook. |
| Smart Crop | Crop keeping the most "interesting" region. |
| Scale and Smart Crop | Scale then smart-crop to exact dimensions. |
| Auto Orient | Rotate per EXIF orientation (uses `file_mdm_exif`). |
| Strip Metadata | Remove EXIF/metadata. |
| Gaussian Blur | Blur with a configurable radius. |
| Pixelate | Pixelate the image. |
| Brightness / Contrast | Adjust brightness or contrast. |
| Color Shift / Invert | Shift toward a color / invert colors. |
| Convolution / Convolution Sharpen | Apply a convolution matrix / sharpen. |
| Mirror | Flip horizontally/vertically. |
| Background | Place a transparent image over a background image/color. |
| Mask | Mask the image with another image. |
| Opacity | Change overall opacity. |
| Set Transparent Color | Set a color as transparent. |
| Set Canvas | Resize the canvas with padding/anchor. |
| Rotate | Rotate arbitrary degrees with background color. |
| Relative Crop | Crop by percentage of dimensions. |
| Resize Percentage | Resize by percentage. |
| Aspect Switcher | Apply different effects for portrait vs landscape. |
| Interlace | Progressive/interlaced output. |
| ImageMagick Arguments | Pass raw ImageMagick CLI arguments (ImageMagick toolkit only). |

Anchoring for several effects is shared via `AnchorTrait`.
