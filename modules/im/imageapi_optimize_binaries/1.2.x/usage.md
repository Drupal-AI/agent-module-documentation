<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Optimize - Binaries adds a family of ImageAPI Optimize processor plugins that shrink generated image-style derivatives by shelling out to locally installed command-line image tools (jpegoptim, jpegtran, optipng, pngquant, pngcrush, pngout, advdef, advpng, jfifremove).

---

The module extends the Image Optimize (`imageapi_optimize`) framework: that base module defines the *pipeline* config entity and the `ImageAPIOptimizeProcessor` plugin type, and this module supplies nine concrete processor plugins that each wrap a well-known binary. Every processor extends `ImageAPIOptimizeProcessorBinaryBase`, which auto-locates the executable on `$PATH` (or uses an admin-supplied `manual_executable_path`), builds a shell command, and runs it against the derivative file via the shared `imageapi_optimize_binaries.shell_operations` service. You use them by adding one or more processors to an Image Optimize *pipeline* (a `imageapi_optimize_pipeline` config entity), then selecting that pipeline as an image style's optimization pipeline or as the site default (`imageapi_optimize.settings:default_pipeline`). The module ships a ready-made optional pipeline `local_binaries` containing all nine processors in a sensible order. Each processor stores its own settings (quality, level, mode, progressive, etc.) plus the optional binary path, validated by config schema. A `configure imageapi_optimize_binary paths` permission gates the ability to override executable paths. Nothing runs unless the corresponding binary is actually installed on the server; a missing binary makes that processor a no-op with a "Command not found" summary.

---

- Losslessly shrink JPEG image-style derivatives with `jpegoptim` (`--strip-all`).
- Strip EXIF/metadata from JPEGs to reduce file size and remove sensitive data.
- Optimize PNG derivatives with `optipng` at a chosen optimization level.
- Apply lossy but high-quality PNG compression with `pngquant` (quality min/max range).
- Run `jpegtran` to produce progressive JPEGs for faster perceived loading.
- Chain several binaries in one pipeline so each image passes through multiple optimizers.
- Use the ready-made `local_binaries` pipeline instead of configuring processors by hand.
- Set a site-wide default optimization pipeline for every image style.
- Attach an optimization pipeline to a single image style only (e.g. only large hero images).
- Override the auto-detected path to a binary when it lives in a non-standard location.
- Reduce total page weight and improve Core Web Vitals / Lighthouse image scores.
- Cut CDN/bandwidth costs by serving smaller images.
- Convert JPEGs to progressive or baseline consistently across a site.
- Recompress `.png` files with `advpng`/`advdef` at a chosen mode.
- Remove the JFIF header from JPEGs with `jfifremove` to trim a few bytes.
- Squeeze the maximum out of PNGs with `pngout` where it is installed.
- Run `pngcrush` as a portable PNG optimizer when other tools are unavailable.
- Target a specific output filesize percentage for JPEGs with `jpegoptim --size`.
- Cap JPEG quality (e.g. `--max=80`) to guarantee an upper bound on size.
- Build environment-specific pipelines (e.g. skip binaries not installed on a given host).
- Combine with the sibling `imageapi_optimize_webp` module to also emit WebP copies.
- Let non-admin roles configure processors while restricting who can set raw executable paths.
- Diagnose why a processor is inactive via its "Command not found" summary on the pipeline form.
- Automate optimization as part of normal image style derivative generation (no cron needed).
- Optimize media/library images without changing the originals — only derivatives are processed.
- Script pipeline creation and processor configuration through exported configuration.
