# Images Optimizer — manual setup guide

**Images Optimizer** (`images_optimizer`) shrinks the file size of images
automatically so pages load faster. Every image that is uploaded is optimized on
the way in — if its file type is handled by one of the registered optimizers, the
module compresses it and replaces the original with the smaller version. If you
use image styles, the derivative images those styles generate are optimized too.

Out of the box the module ships two optimizers: one for **JPEG** images and one
for **PNG** images. These are not pure-PHP compressors — each one shells out to a
well-known command-line tool, so those tools must be installed on the server for
the optimizers to work: **jpegoptim** for JPEGs and **pngquant** for PNGs. If a
tool is missing, that optimizer simply cannot run. For anything beyond the two
built-ins, a developer can register a custom optimizer service, but most sites
just use the pair provided.

One thing to be clear about: **the original uploaded image is destroyed in the
process** — optimization overwrites it with the compressed version. That is the
whole point (you want the smaller file), but it means you should be comfortable
with the compression settings before turning it loose on real uploads.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and install the `jpegoptim` and `pngquant` command-line tools.
2. [Configuration](configuration/index.md) — choose which optimizers to use and
   tune their options.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → Images
Optimizer** (`/admin/config/media/images-optimizer`), where you pick the
optimizers to run and configure their options.
