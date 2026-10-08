Image Optimize (ImageAPI Optimize) lets you build reusable image-optimization pipelines from pluggable processors and attach them to core image styles so every derived image is automatically compressed.

---

The module adds an "optimization pipeline" config entity: an ordered, weighted list of processor plugins that each transform a generated image file — for example stripping metadata, recompressing JPEG/PNG, or converting to WebP. Pipelines are managed at Admin → Configuration → Media → Image Optimize pipelines, where you create pipelines, add and order processors, and configure each processor's settings. A site-wide default pipeline can be set, and individual image styles can use a specific pipeline via the bundled `ImageStyleWithPipeline` integration, so optimization runs transparently whenever core generates an image derivative. The actual optimizers ship as separate processor plugins (from companion projects such as reSmush.it, local binaries, etc.); this base module provides the pipeline framework, the `ImageAPIOptimizeProcessor` plugin type, base classes for configurable processors, and the admin UI. Flushing a pipeline regenerates affected derivatives. Developers extend it by writing new processor plugins or altering the processor list with `hook_imageapi_optimize_processor_info_alter()`. It is a drop-in performance/SEO win: smaller images without changing how content is authored.

---

- Automatically compress every image derivative core generates.
- Build a pipeline that strips metadata then recompresses JPEGs.
- Convert generated images to WebP for faster page loads.
- Set a site-wide default optimization pipeline.
- Assign a specific pipeline to a single image style.
- Order processors so lossless steps run before lossy ones.
- Reduce bandwidth and improve Core Web Vitals via smaller images.
- Use a remote optimizer service (e.g. reSmush.it) as a processor.
- Use local command-line binaries (jpegoptim, optipng) as processors.
- Configure per-processor quality/compression settings.
- Flush a pipeline to regenerate all affected image derivatives.
- Apply different optimization levels to thumbnails vs. hero images.
- Keep optimization transparent to content editors.
- Chain multiple optimizers in a single pipeline.
- Improve SEO by serving lighter images.
- Export image optimization pipelines as configuration between environments.
- Restrict pipeline administration to trusted roles via permission.
- Optimize responsive image style derivatives automatically.
- Add a custom processor plugin for a new optimization tool.
- Alter available processors in code via a hook.
- Disable optimization for a style by pointing it at an empty pipeline.
- Standardize image compression policy across a whole site.
- Test different pipelines and compare output sizes.
- Integrate an in-house image CDN/optimizer as a processor.
