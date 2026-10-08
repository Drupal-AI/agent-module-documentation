# ImageAPI Optimize processor

WebP ships one plugin implementing the **ImageAPI Optimize** processor type (defined by the
`imageapi_optimize` contrib module — WebP does not define the plugin type itself):

- **`Plugin/ImageAPIOptimizeProcessor/Webp.php`** — id `webp_webp`, label "WebP".
  Add it to an ImageAPI Optimize pipeline to produce WebP output as part of that pipeline.
  Its own config (schema key `imageapi_optimize.processor.webp_webp`) has a single `quality`
  integer.

This is only relevant if you use the ImageAPI Optimize module; the core WebP behavior (see
[../extend/integration.md](../extend/integration.md)) works without it.
