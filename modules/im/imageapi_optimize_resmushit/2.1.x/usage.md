Image Optimize - reSmush.it adds a single **`resmushit`** image-optimize processor plugin to the Image Optimize (ImageAPI Optimize) pipeline system, sending each derived image to the free reSmush.it web service for lossy/lossless compression and saving the smaller result back in place.

---

The module ships one plugin: an `@ImageAPIOptimizeProcessor` with id **`resmushit`** (`Drupal\imageapi_optimize_resmushit\Plugin\ImageAPIOptimizeProcessor\ReSmushit`), extending `ConfigurableImageAPIOptimizeProcessorBase` from the required **imageapi_optimize** module. It has no admin page or config entity of its own — it is *used inside* an `imageapi_optimize_pipeline` config entity (config prefix `imageapi_optimize.pipeline.*`). You add the processor to a pipeline at **Admin → Configuration → Media → Image Optimize pipelines** (`/admin/config/media/imageapi-optimize-pipelines`), and each pipeline is then attached to one or more image styles so that every generated derivative is optimized. The processor exposes exactly one setting, **`quality`** (an integer 1–100, "JPEG image quality"), stored per-processor-instance under the pipeline's `processors` array as `data.quality`; leaving it empty sends no `qlty` parameter to the service. At runtime `applyToImage()` POSTs the file (multipart, field `files`, plus `qlty` when quality is set) to `http://api.resmush.it/ws.php`, reads the `dest` URL from the JSON response, downloads the optimized image and overwrites the local file; failures are logged to the `imageapi_optimize` channel and the original is left untouched. **Because optimization depends on a live call to the third-party reSmush.it API, an actual optimize run needs network access and the remote service to be up — so any reliable check of "is it set up correctly" should assert against the pipeline config (the processor is present with the intended quality), not against a live optimize round-trip.** The installed release is `2.1.0-beta1` (a beta).

---

- Register a reSmush.it optimizer for the Image Optimize pipeline system.
- Add the `resmushit` processor to an existing `imageapi_optimize_pipeline`.
- Create a new pipeline whose only step is the reSmush.it processor.
- Set a JPEG quality (1–100) so lossy compression trades size for fidelity.
- Leave quality empty to let reSmush.it use its own default optimization.
- Attach a reSmush.it pipeline to an image style so all its derivatives are compressed.
- Shrink responsive-image derivatives across every configured breakpoint.
- Optimize thumbnail and teaser image styles to cut page weight.
- Chain reSmush.it after a resize/crop step in a multi-processor pipeline.
- Offload image compression to a free external service instead of local binaries.
- Reduce hosting bandwidth by serving smaller JPEG/PNG derivatives.
- Apply one shared optimization policy site-wide via a single reused pipeline.
- Run different quality levels per pipeline (e.g. aggressive for thumbnails, gentle for hero images).
- Compress user-uploaded images automatically as their styles are generated.
- Improve Largest Contentful Paint by delivering lighter above-the-fold images.
- Flush a pipeline to force affected image derivatives to be regenerated and re-optimized.
- Programmatically add the processor to a pipeline with `addProcessor(['id' => 'resmushit', 'data' => ['quality' => 80]])`.
- Export a reSmush.it pipeline as config for deployment across environments.
- Log and diagnose failed optimizations via the `imageapi_optimize` logger channel.
- Fall back gracefully (original image kept) when reSmush.it is unreachable.
- Standardize image compression without installing jpegoptim/optipng/pngquant locally.
- Combine with core Responsive Image to optimize every generated size.
- Lower storage use for large media libraries by compressing derivatives.
- Provide a no-binary optimization path on hosts where CLI tools cannot be installed.
