# Configuration

Cloudimage needs configuration before it will optimize anything. All settings live
on one form at **Configuration → Cloudimage by Scaleflex**
(`/admin/config/cloudimage-by-scaleflex`), which requires the **Administer site
configuration** permission.

## Before you start

Create a Cloudimage token at [Scaleflex](https://www.scaleflex.com/). You'll paste
this token (or your CNAME) into the form below.

## The settings, field by field

- **Cloudimage token / CNAME** — your Cloudimage account token, or a custom CNAME
  if you've set one up. This is the identifier that tells Cloudimage which account
  the transformed images belong to. Nothing works without it.
- **Activation (enable/disable)** — the master switch that turns image
  optimization on or off site‑wide. Leave it off while you finish configuring, then
  turn it on.
- **Standard (no‑JavaScript) mode** — when enabled, the module rewrites `<img>`
  URLs server‑side so images come straight from the Cloudimage CDN without loading
  any JavaScript. When disabled, the module attaches the Cloudimage JS library and
  transforms images in the browser (which also enables responsive resizing and lazy
  loading).
- **Use origin URL** — keeps the original image URL as the source, which helps
  avoid "double‑CDN" situations where images are already served through another CDN.
- **Lazy loading** — defers loading of off‑screen images until the visitor scrolls
  to them, saving bandwidth on long pages (JavaScript mode).
- **Ignore SVG** — leaves SVG images out of Cloudimage processing (SVGs are
  vector and don't benefit from raster optimization).
- **Prevent upsizing** — stops small images from being scaled up beyond their
  natural size.
- **Image quality** — the compression quality level; lower values mean smaller
  files but more visible compression.
- **Maximum pixel ratio** — caps the device pixel ratio used for retina/high‑DPI
  screens, balancing sharpness against file size.
- **Remove `/v7`** — strips the `/v7` segment from Cloudimage URLs, needed for
  newer token formats.
- **Image size attributes** — controls whether width/height attributes are set so
  the browser can reserve layout space and calculate sizing.
- **Custom JavaScript function** and **Custom library options** — advanced fields
  that inject an admin‑supplied JavaScript transform function and extra Cloudimage
  library parameters (for example, to add a watermark). Because these inject code
  and parameters into the front end, treat them as a **trusted‑administrator‑only**
  feature and do not expose this form to untrusted roles.

## Save

Enter your token, choose standard or JavaScript mode, set a sensible quality and
pixel ratio, then enable activation and **save**. Reload a page with images and
confirm the image URLs now point at the Cloudimage CDN.
