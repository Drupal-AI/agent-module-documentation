# Configuration

Image Optimize is configured entirely through **pipelines**, managed at
**Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`). Everything here requires the
**Administer imageapi optimize pipelines** permission. Pipelines are configuration
entities, so they export and deploy like any other config.

## Create a pipeline

On the pipelines collection page, click **Add pipeline** and give it a **Label**
and a **machine name**. A pipeline on its own does nothing until you add
processors.

## Add and order processors

Open a pipeline to edit it, then add processors — the individual optimization steps
that come from your installed processor modules. For each processor you can:

- **Configure its settings** — for example a quality or compression level, or the
  connection details for a remote optimizer service. The available options depend
  on the processor.
- **Set its weight** — processors run in weight order, top to bottom. Put lossless
  steps (like stripping metadata) before lossy steps (like recompression) so each
  step operates on the best available input.

Add as many processors as you like to chain multiple optimizers in one pipeline.

## Set the site‑wide default pipeline

On the pipelines collection page you can choose one pipeline as the **default**,
which every image style uses unless overridden. This is stored in
`imageapi_optimize.settings` under `default_pipeline`, and can also be set from the
command line:

```bash
drush config:set imageapi_optimize.settings default_pipeline my_pipeline -y
```

## Assign a pipeline to a specific image style

Beyond the default, an individual core image style can be given its own pipeline,
overriding the site default for just that style. This lets you, say, compress
thumbnails aggressively while leaving hero images higher quality. Point a style at
an empty pipeline to effectively disable optimization for it.

## Flush after changes

Whenever you change a pipeline's processors, **flush** the pipeline (there is a
flush form for each pipeline) to regenerate the affected image derivatives so they
pick up the new optimization. Until you flush, previously generated derivatives
keep their old compression.
