Image Optimize - TinyPNG adds a **TinyPNG processor** to the ImageAPI Optimize (Image Optimize) pipeline system, compressing generated JPEG/PNG image derivatives through the hosted TinyPNG/Tinify web service using the official `tinify/tinify` PHP library.

---

The module ships one plugin, `\Drupal\imageapi_optimize_tinypng\Plugin\ImageAPIOptimizeProcessor\TinyPng` (`@ImageAPIOptimizeProcessor(id = "tinypng")`), extending `ConfigurableImageAPIOptimizeProcessorBase` from the required `imageapi_optimize` module. You add it as a processor to an Image Optimize pipeline at *Configuration → Media → Image Optimize pipelines*; the pipeline is then assigned to image styles so every derivative that style produces is post-processed. The processor's only setting is `api_key` (default `NULL`, schema `imageapi_optimize.processor.tinypng`), entered on the processor's configuration form and validated live against TinyPNG via `\Tinify\validate()`. `applyToImage($image_uri)` reads the on-disk derivative, sends its bytes to TinyPNG with `\Tinify\fromBuffer(...)->toBuffer()`, and writes the optimized result back over the same URI; all Tinify exceptions (account/limit, client, server, connection) are caught and logged to the `imageapi_optimize` channel, returning FALSE on failure. `hook_requirements` flags an error if the `\Tinify\Tinify` class is missing (install `tinify/tinify` via Composer — done automatically when you require this module). The API key is stored in the pipeline processor configuration; because Drupal config can be overridden from `settings.php`/environment, keep production keys out of committed config exports. Each optimized image is one metered TinyPNG API call.

---

- Compress PNG image-style derivatives through TinyPNG to cut page weight.
- Compress JPEG derivatives via the same TinyPNG/Tinify service.
- Add TinyPNG as one step in a multi-processor Image Optimize pipeline.
- Assign a TinyPNG-enabled pipeline to specific image styles (e.g. large hero images).
- Reduce bandwidth and improve Core Web Vitals (LCP) with smaller images.
- Offload image optimization to a hosted service instead of local binaries (jpegoptim/optipng).
- Validate a TinyPNG API key at configuration time before saving the processor.
- Log optimization failures (quota exceeded, network errors) to Drupal's logger for monitoring.
- Optimize images on hosting where you cannot install command-line optimizer tools.
- Combine TinyPNG with WebP or resize processors in a single pipeline.
- Centralize image optimization policy by reusing one pipeline across many styles.
- Keep the original source image intact while only derivatives are compressed.
- Meter and control image-optimization cost by scoping the pipeline to selected styles.
- Regenerate optimized derivatives simply by flushing the image style.
- Provide TinyPNG compression for editorial images uploaded via media.
