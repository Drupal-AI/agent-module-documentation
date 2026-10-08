# Configuration

ImageAPI Optimize GD has no settings page of its own. You configure it by adding
its **GD** processor to an Image Optimize **pipeline**, then applying that pipeline
to your image styles. The whole flow lives inside ImageAPI Optimize's admin area.

## 1. Create (or edit) a pipeline

1. Go to **Configuration → Media → Image Optimize pipelines**
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. Add a pipeline and give it a label/name (for example *Standard compression*).

## 2. Add the GD processor and set its options

On the pipeline's edit form:

1. Under **Select a new processor**, choose **GD** and click **Add**.
2. Configure the two settings:
   - **Image quality** — a number from **1 to 100** (default **75**). Lower means
     smaller files but more visible compression; higher means better-looking
     images but larger files. Around 75 is a good general default; use 85–90 for
     hero images and 50–65 for small thumbnails.
   - **File types** — tick which formats this processor should re-compress:
     **JPEG** and/or **WebP**. At least one must be selected. Any other file type
     (PNG, GIF, SVG, …) is left untouched.
3. Click **Add processor** / save the pipeline.

You can add the GD processor more than once, or alongside other ImageAPI Optimize
processors (for example a WebP generator or reSmush.it), and order them by weight
within the pipeline.

## 3. Apply the pipeline to image styles

A pipeline does nothing until an image style uses it. You have two options:

- **Per image style** — go to **Configuration → Media → Image styles**, edit a
  style, and at the bottom choose your pipeline (or *Sitewide default pipeline*),
  then save.
- **Sitewide default** — on the Image Optimize pipelines overview, set a **Sitewide
  default pipeline**. Every image style set to *Sitewide default pipeline* then
  uses it.

## 4. Recompress existing derivatives

Changing quality only affects newly generated derivatives. To re-optimize images
that were already generated, **flush** the affected image styles (from the image
styles page, or `drush image:flush`). New derivatives are then created at the new
quality.

## Recommended setup

Leave Drupal's **sitewide GD image toolkit** quality at **100%** (at
**Configuration → Media → Image toolkit**) and let the ImageAPI Optimize pipeline
own the actual quality via this processor. That keeps compression separate from
crop/scale/overlay effects and gives you predictable, per-style output sizes.

## Where it's stored

The processor settings live on the pipeline configuration entity
(`imageapi_optimize.pipeline.<id>`), and the sitewide default is in
`imageapi_optimize.settings`. Both export and import with your site
configuration, so you can standardize image quality across environments or a
multisite platform. Inspect a pipeline with
`drush cget imageapi_optimize.pipeline.<id>`.
