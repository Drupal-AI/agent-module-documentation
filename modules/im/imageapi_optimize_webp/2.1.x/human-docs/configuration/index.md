# Configuration

This module doesn't have a settings page of its own. You configure WebP output
through **ImageAPI Optimize pipelines**, using the **WebP Deriver** processor this
module adds. There are three steps: build a pipeline, add the WebP Deriver to it,
and apply the pipeline to your image styles.

## 1. Create a pipeline with the WebP Deriver

1. Go to **Configuration → Media → Image Optimize pipelines**
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. Click to add a new pipeline and give it a name (for example "WebP").
3. In **Select a new processor**, choose **WebP Deriver** and click **Add**.
4. Set the processor's options (below), click **Add processor**, then **Save**
   the pipeline.

### The WebP Deriver's setting

- **Image quality** — a number from 1 to 100 (default **75**) that controls the
  WebP compression level. Higher means better-looking images but larger files;
  lower means smaller files but more visible compression. 75 is a good balance;
  drop toward 60 for maximum savings, or raise toward 85 for photography where
  quality matters most.

That's the only setting this module adds. The value is stored inside the pipeline
alongside the processor.

## 2. Apply the pipeline

You have two ways to put the pipeline to work:

- **Sitewide default** — on the Image Optimize pipelines page, set your WebP
  pipeline as the **Sitewide default pipeline**. Every image style that doesn't
  specify its own pipeline will then use it, so WebP copies are generated for all
  styled images.
- **Per image style** — go to **Configuration → Media → Image styles**
  (`/admin/config/media/image-styles`), edit a style, and choose your WebP
  pipeline at the bottom of the style's edit form. Use this when you only want
  WebP for particular styles.

## 3. What happens next

Once a pipeline containing the WebP Deriver is applied to a style, the module
works automatically:

- For each styled image derivative (say `…/styles/thumb/public/foo.jpg`), a
  matching WebP file is written next to it (`…/foo.jpg.webp`).
- When a browser requests the `.webp` URL, the module serves that file with a
  `Content-Type: image/webp` header, generating the underlying derivative on
  demand if needed.
- When an image style is flushed, the stale `.webp` files are cleaned up too.

## Making browsers use the WebP

The base module produces and serves the `.webp` files, but your markup has to
point at them — typically through a `<picture>` element or a `srcset` that offers
the WebP URL. If you use core **responsive image** fields, enable the
**imageapi_optimize_webp_responsive** submodule instead and it adds the WebP
`<source>` automatically, with no template changes.

## Verify it worked

Visit a page with a styled image, then request the same image URL with `.webp`
appended (for example `…/styles/thumb/public/foo.jpg.webp`). If you receive a WebP
image, generation and serving are working. You can also confirm the pipeline
contains the processor from the command line:

```bash
drush cget imageapi_optimize.pipeline.<your_pipeline_name> processors
```
