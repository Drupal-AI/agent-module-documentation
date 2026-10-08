# Original image with style — manual setup guide

**Original image with style** (`original_image_style`) permanently applies a
chosen **image style** to the *original* uploaded file — overwriting the stored
source image in place — rather than only generating on‑the‑fly derivatives. In
other words, if you upload a 6000×4000 photo and the field is set to a "Max
1600px" style, the file that ends up on disk is the 1600px version; the
full‑resolution original is not kept.

This is handy when you never need the huge original: it caps disk usage, cuts
bandwidth on the base file (not just responsive variants), and can bake in
effects like scaling, cropping, or watermarking at upload time. Because the
processed width and height are written back to the field, everything downstream
sees the new dimensions.

There is **no global settings page**. You switch this behavior on **per image
field** using a third‑party setting the module adds to each image field's
configuration form.

> **Important — this is destructive and irreversible.** Once the original upload
> is overwritten, the full‑resolution file is gone. Don't use it on fields where
> you may later need the untouched original (archival, print, re‑cropping). Only
> newly added files are processed; images carried over from a previous revision
> are left alone, so existing content isn't reprocessed on every save.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
turn it on per field, described in "How to use it" below.

## How to use it

1. Go to the field you want to affect: **Structure → Content types → *(type)* →
   Manage fields → *(your image field)* → Edit**.
2. On the field's settings form, find the third‑party setting **"Apply style to
   image after upload"** and choose the image style to apply (the styles listed
   are the ones defined at **Configuration → Media → Image styles**).
3. Save the field. From now on, each newly uploaded image on that field is
   processed through the selected style on save, and the resized/processed file
   replaces the original on disk.

Repeat per image field. Fields left with no style selected behave normally and
keep their originals untouched.
