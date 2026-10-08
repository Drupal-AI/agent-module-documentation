# Image Sizes — manual setup guide

**Image Sizes** (`image_sizes`) makes images responsive to *their container*
rather than only to the browser viewport. It picks an image style based on the
width of the parent element, so the same image gets a smaller derivative when it
sits in a narrow column and a larger one when it fills a wide hero. The goal is
to stop serving oversized images into small slots — which is exactly what page‑
speed tools reward.

You work with Image Sizes through **presets**. A preset is a named mapping of
container widths to image styles; you create presets from the command line with
the module's Drush command (`drush isg`), and then apply them to an image field
using the field formatter this module provides. An optional submodule,
**Image Sizes Defaults** (`image_sizes_defaults`), ships a set of ready‑made
presets so you have sensible standards to start from.

Image Sizes depends only on core's Image module. It pairs well with
[Focal Point](https://www.drupal.org/project/focal_point) and
[Image Widget Crop](https://www.drupal.org/project/image_widget_crop) when you
generate presets with a fixed aspect ratio, and with
[Image Effects](https://www.drupal.org/project/image_effects) when you want a
blurred placeholder thumbnail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the defaults submodule.

There is **no central settings form**: presets are created with Drush and applied
per field, both described in "How to use it" below.

## Where it lives in the admin menu

Image Sizes adds no dedicated admin page. Presets are created via Drush, and you
apply the formatter from **Structure → Content types → *(bundle)* → Manage
display** (Field UI) on the image field you want to make responsive.

## How to use it

1. **Create a preset with Drush.** The `isg` command takes a label, a minimum
   width, a maximum width, and a step. For example:

   ```bash
   # Generate a preset named "Default" from 100px to 1400px in 100px steps
   drush isg "Default" 100 1400 100

   # Add a blurred placeholder (requires the image_effects module)
   drush isg "Default" 100 1400 100 --generate-thumbnail

   # Generate styles with a 4x3 aspect ratio
   drush isg "Default" 100 1400 100 --ratio=4x3

   # Use focal point for the crop (only with --ratio)
   drush isg "Default" 100 1400 100 --ratio=4x3 --use-focal-point

   # Use Image Widget Crop for the crop (only with --ratio)
   drush isg "Default" 100 1400 100 --ratio=4x3 --use-manual-crop

   # Output PNG instead of the default WebP
   drush isg "Default" 100 1400 100 --format=png
   ```

2. **Or start from the defaults.** Enable the **Image Sizes Defaults** submodule
   (see [Installation](installation/index.md)) to get a set of standard presets
   without writing any Drush commands.

3. **Apply the formatter to a field.** Go to the image field's **Manage display**
   and set its format to the Image Sizes formatter. Choose the preset you created,
   save, and the module will select the right image style per container width.

> **Tip:** Presets generate WebP by default. If you need a different format,
> pass `--format=png` (or another supported format) when you create the preset.
