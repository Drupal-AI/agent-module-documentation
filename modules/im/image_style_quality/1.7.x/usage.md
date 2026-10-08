Image Style Quality adds an image effect that lets you set the output quality (compression) per image style, so different derivatives of the same source image can use different JPEG/WebP quality levels.

---

The module provides a configurable `image_style_quality` **image effect** (extends core's `ConfigurableImageEffectBase`) whose only setting is `quality` (an integer 0–100, default 75). When the effect runs during derivative generation it does not touch pixels directly — instead it calls `setModuleOverride()` on the active image toolkit's quality config so the toolkit encodes that derivative at the chosen quality. Which config object/key to override is resolved through a small plugin type the module defines, `mutable_quality_toolkits` (a YAML plugin discovery managed by the `image_style_quality.mutable_quality_toolkit_manager` service), shipped with definitions for the three common toolkits: GD (`system.image.gd` → `jpeg_quality`), ImageMagick (`imagemagick.settings` → `quality`), and Imagick (`imagick.config` → `jpeg_quality`). Because it targets the toolkit's generic quality setting, it affects the formats that setting governs for the active toolkit. You add the effect to an image style just like any other effect (Manage → Image styles), typically ordered after the resize/scale effects. It depends on core `image`, suggests `imagemagick`/`imagick`, defines no routes, permissions, or Drush commands, and exposes a `mutable_quality_toolkits` alter hook for adding support for other toolkits.

---

- Serve thumbnails at low quality (small files) while keeping large images at high quality.
- Set a specific JPEG quality per image style instead of one global toolkit value.
- Reduce page weight by lowering quality on decorative/preview derivatives.
- Keep hero/full-width images crisp with a high-quality effect while compressing list thumbnails.
- Tune quality per breakpoint by giving each responsive image style its own quality.
- Apply quality to derivatives produced by the GD toolkit (`jpeg_quality`).
- Apply quality to derivatives produced by ImageMagick (`imagemagick.settings:quality`).
- Apply quality to derivatives produced by Imagick (`imagick.config:jpeg_quality`).
- Optimize images for performance budgets without external services.
- A/B different quality levels by cloning a style and changing only the quality effect.
- Combine with scale/crop effects, placing the quality effect last in the pipeline.
- Lower quality on retina @2x styles where perceived quality tolerance is higher.
- Standardize a "web" quality (e.g. 60) across many styles.
- Keep print/download styles at 100 while web styles are compressed.
- Add quality control to a media library's derived styles.
- Support a custom toolkit by adding a `*.mutable_quality_toolkits.yml` definition.
- Override the toolkit quality only for the current derivative, leaving the global setting intact.
- Provide predictable per-style file sizes for a CDN cache.
- Reduce storage used by generated derivatives.
- Give editors no extra UI — it is a normal image-effect they add to a style.
- Set a conservative default (75) and override per style as needed.
- Fine-tune quality for WebP output where the active toolkit maps quality to that format.
- Roll quality settings through config export as part of the image style config.
