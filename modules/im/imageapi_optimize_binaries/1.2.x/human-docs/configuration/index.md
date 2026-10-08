# Configuration

Image Optimize - Binaries has no configuration screen of its own — you configure it through the
parent **Image Optimize** module's *pipeline* screens. The overall flow is: build (or reuse) a
**pipeline** made of these binary processors, then tell your image styles to use that pipeline.
Optimization then runs automatically whenever an image‑style derivative is generated.

## Option A: use the shipped "Local Binaries" pipeline

Enabling the module installs a ready‑made pipeline called **Local Binaries** that already
contains all nine processors in a sensible order (advdef → advpng → jfifremove → jpegoptim →
jpegtran → optipng → pngcrush → pngout → pngquant). If you just want to optimize everything, this
is the quickest path — you can skip straight to "Attach a pipeline to your images" below and
select **Local Binaries**. Processors whose binaries aren't installed are simply skipped.

## Option B: build your own pipeline

1. Go to **Configuration → Media → Image Optimize pipelines**
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. Click **Add pipeline**, give it a label, and save.
3. Click **Add processor**, choose one of the binary processors (for example *JpegOptim*,
   *OptiPNG*, or *pngquant*), set its options, and save. The available processors are:

   | Processor | Binary | What it does |
   |-----------|--------|--------------|
   | JpegOptim | `jpegoptim` | Optimizes JPEGs, strips metadata; optional quality cap, target size, progressive output |
   | jpegtran | `jpegtran` | Lossless JPEG transforms; can produce progressive JPEGs |
   | jfifremove | `jfifremove` | Removes the JFIF header from JPEGs to trim a few bytes |
   | OptiPNG | `optipng` | Lossless PNG optimizer, optimization level 0–7 |
   | pngquant | `pngquant` | Lossy (palette) PNG compression with a min/max quality range |
   | pngcrush | `pngcrush` | Portable PNG optimizer |
   | pngout | `pngout` | Aggressive PNG optimizer |
   | advdef | `advdef` | Recompresses the deflate stream in PNGs |
   | advpng | `advpng` | PNG recompression |

4. Add as many processors as you like — an image passes through each in order, so you can chain,
   say, `optipng` then `advpng` on PNGs and `jpegoptim` then `jpegtran` on JPEGs.

Each processor has a few settings (quality, level, mode, progressive, and so on) plus an optional
manual path to the binary. The path field only appears if you hold the permission below.

## Attach a pipeline to your images

A pipeline does nothing until something uses it. You can apply it two ways:

- **Site‑wide default** — set it as the default optimization pipeline so every image style uses
  it. From Drush:

  ```bash
  drush cset imageapi_optimize.settings default_pipeline local_binaries -y
  ```

  (or set the default on the Image Optimize settings page.)
- **Per image style** — edit a specific image style (**Configuration → Media → Image styles**)
  and choose its **Optimization pipeline**. This is useful when you only want to optimize certain
  styles, such as large hero images.

Optimization is applied when the derivative is created, so newly generated derivatives are
optimized automatically — no cron needed. To re‑optimize existing derivatives, flush the image
styles so they regenerate.

## Permission: overriding binary paths

The module defines one permission, **Configure Image Optimize Binary paths** (`configure
imageapi_optimize_binary paths`). It controls whether the **"Manually set path"** field appears on
a processor's configuration form — that is, whether a user can override the auto‑detected
executable path with an arbitrary server path.

This is a security‑sensitive permission (Drupal flags it as restricted): choosing a binary path is
effectively choosing what command the server runs, so grant it only to trusted administrators.
Without it, users can still add processors and set their non‑path options; they just can't change
the executable path. Normally you don't need to set a manual path at all — leave it blank and the
processor finds the binary on the system `$PATH`.

## Deploying the configuration

Pipelines are configuration entities and the default‑pipeline choice is a simple config value, so
both export and import like any other configuration. Just remember that the target environment
still needs the actual binaries installed for the processors to do anything.
