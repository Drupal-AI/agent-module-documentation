# Image Optimize - Binaries — manual setup guide

**Image Optimize - Binaries** (`imageapi_optimize_binaries`) shrinks the image derivatives
Drupal generates for image styles by running well‑known command‑line optimization tools on
them. It adds nine processor plugins to the **Image Optimize** (`imageapi_optimize`)
framework, each wrapping a familiar binary — `jpegoptim`, `jpegtran`, `optipng`, `pngquant`,
`pngcrush`, `pngout`, `advdef`, `advpng`, and `jfifremove`. The result is smaller images,
lighter pages, better Core Web Vitals / Lighthouse scores, and reduced CDN/bandwidth costs —
all applied automatically as part of normal image‑style derivative generation, and only ever
to the derivatives, never your original uploads.

The way it fits together: the base Image Optimize module provides the concept of a
**pipeline** (an ordered list of optimization processors) and lets you attach a pipeline to
an image style or set one as the site default. This module supplies the concrete processors
you put in a pipeline. It even ships a ready‑made pipeline, **Local Binaries**, containing all
nine processors in a sensible order, so you can get going without configuring each processor
by hand.

The one hard requirement is that **the corresponding binary must actually be installed on the
server**. Each processor auto‑locates its executable on the system `$PATH` (or you can point
it at a specific path); if the tool isn't installed, that processor simply does nothing — a
silent no‑op whose pipeline summary reads *"Command not found"*. Because overriding a binary's
path effectively chooses what command the server runs, a dedicated permission gates that
ability. The module works on **Drupal 8 through 11** and requires **Image Optimize** (`^4`).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including each processor's settings and the
shell‑operations service — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and make
   sure the optimization binaries are present on the server.
2. [Configuration](configuration/index.md) — build a pipeline (or use the shipped one), attach
   it to image styles, and the permission that controls binary paths.

## Where it lives in the admin menu

This module has no admin page of its own. Everything is configured through the parent Image
Optimize module's screens: **Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`) for building pipelines, and each image
style's edit form for choosing which pipeline it uses.

## How to use it

Install the module, install the optimization tools you want on the server, then either enable
the shipped **Local Binaries** pipeline or build your own from these processors, and finally
point your image styles (or the site default) at that pipeline. Optimization then happens
automatically the next time each image‑style derivative is generated. The full workflow is in
[Configuration](configuration/index.md).
