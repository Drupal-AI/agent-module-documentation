# Configuration

Kraken.io is configured entirely on a processor inside an **Image Optimize**
pipeline — there is no separate settings page. You need the permission to
administer Image Optimize pipelines (an administrator has it by default).

## Add the Kraken processor to a pipeline

1. Go to **Configuration → Media → Image Optimize pipelines**
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. **Add** a new pipeline (or edit an existing one).
3. Add a processor and choose **Kraken**.

## The Kraken processor options

- **API key** — your Kraken.io API key.
- **API secret** — your Kraken.io API secret. Together these authenticate every
  optimization request.
- **Lossy** — enable to use Kraken.io's lossy compression for noticeably smaller
  files (at some quality cost); leave off for lossless.
- **WebP** — enable to produce WebP derivatives.
- **Logging** — optionally log successful optimizations to Drupal's log for
  debugging.

Save the processor, then assign the pipeline to the image styles you want
optimized. Kraken.io's account and quota status will appear on the **Status
report** (**Reports → Status report**).

## A note on data egress

Every optimized derivative is a round trip to Kraken.io, so first‑render latency
depends on the service and **your images leave your infrastructure to be
processed**. That's usually fine for public images; for anything sensitive, treat
it as a deliberate data‑egress decision and consider optimizing only public images
through Kraken.io.
