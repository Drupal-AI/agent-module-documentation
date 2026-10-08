<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudimage by Scaleflex serves your images through the Cloudimage CDN, resizing, compressing and optimizing them on the fly.

---
A configuration form at `/admin/config/cloudimage-by-scaleflex` (`administer site configuration`) stores your Cloudimage token or CNAME plus rendering options: activation, standard (no-JS) mode, use-origin-URL, lazy loading, SVG ignore, upsize prevention, image quality, maximum pixel ratio, v7 removal, size attributes, a custom JS function and custom library options. The module then either rewrites `<img>` URLs server-side (standard mode) or attaches the Cloudimage JS library to transform images in the browser.

Setup: create a Cloudimage token at scaleflex, enter it in the form, choose standard or JS mode and quality/pixel-ratio, then enable. The `custom_function`/`custom_library` fields inject admin-provided JS/parameters, so restrict configuration to trusted administrators.
---
- Enter your Cloudimage token or CNAME.
- Enable/disable image optimization globally.
- Serve responsive, CDN-optimized images.
- Compress images to a chosen quality level.
- Set the maximum device pixel ratio (retina).
- Enable lazy loading of off-screen images.
- Use standard (no-JavaScript) URL rewriting.
- Keep origin URLs to avoid double-CDN.
- Ignore SVG images from processing.
- Prevent upsizing of small assets.
- Remove the `/v7` URL segment for newer tokens.
- Add a watermark via custom library parameters.
- Provide a custom JS transform function.
- Set image size attributes for width/height calc.
- Speed up page loads with a global image CDN.
- Restrict Cloudimage settings to administrators.
