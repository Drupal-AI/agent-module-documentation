# Configuration

Image Processor (WebP) provides a backend settings interface where you decide how
images are processed. The available options are:

## Image processing library (toolkit)

Choose which toolkit does the conversion — for example **GD** or **ImageMagick**.
Both can produce WebP on a suitably built server; ImageMagick often gives more
control over quality and format support, while GD is Drupal's default and needs no
extra software. Pick the one your server has available and configured.

## Automatic conversion toggle

Turn **automatic conversion** on or off. When enabled, the module creates a WebP copy
of each JPG/PNG image as it is uploaded, so optimisation happens transparently
without editor involvement. Turn it off if you want to pause conversion — for
example while testing.

## Default formats and file extensions

Set the **default formats and file extensions** the module applies for the different
media types it handles. This governs which source formats get a WebP copy and how the
generated files are named/served.

## After configuring

Save the settings. With automatic conversion on, newly uploaded JPG/PNG images get a
WebP copy, and the module rewrites `<img>` tags on rendered pages into `<picture>`
elements so supporting browsers receive the WebP version while others fall back to
the original. Upload a test image and inspect the page markup to confirm a
`<picture>` element with a WebP source is being served.
